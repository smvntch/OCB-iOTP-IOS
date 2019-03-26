//
//  ActivateAccountViewController.swift
//  OCBiOTP
//
//  Created by Trinh Quang Son on 11/14/18.
//  Copyright © 2018 sontq00787@gmail.com. All rights reserved.
//

import UIKit

class ActivateAccountViewController: BaseViewController {
    
    @IBOutlet weak var viewNotification: UIView!
    @IBOutlet var txtActivateCodes: [OCBTextField]!
    @IBOutlet weak var btnActive: UIButton!
    @IBOutlet weak var cUserNameToTitle: NSLayoutConstraint!
//    @IBOutlet weak var txtUserName: OCBTextField!
    @IBOutlet var btnLanguages: [UIButton]!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var txtAccountName: OCBTextField!
    @IBOutlet weak var lblEnterActiveCode: UILabel!
    @IBOutlet weak var lblTopMessage: UILabel!
//    @IBOutlet weak var containerViewNumPad: UIView! {
//        didSet {
//            containerViewNumPad.isHidden = true
//        }
//    }
    
    
    var accountVM = AccountViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    fileprivate func initViews() {
        txtActivateCodes.forEach { (textField) in
            textField.delegate = self
            textField.ocbTextDelegate = self
        }
        //register notification for keyboard will show/hide
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        Utility.setBtnLanguageState(buttons: btnLanguages)
    }
    
    fileprivate func fetchTextContent() {
        lblTopMessage.text = "Activation Your Account".localized
        lblUserName.text = "Username".localized
        lblEnterActiveCode.text = "Enter Activation Code".localized
        btnActive.setTitle("Activate".localized, for: .normal)
    }

    // MARK: - Helpers
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardRect = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? CGRect{
            if cUserNameToTitle.constant == 100 {
                UIView.animate(withDuration: 0.5) {
                    self.cUserNameToTitle.constant = 5
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        if cUserNameToTitle.constant < 100 {
            UIView.animate(withDuration: 0.5) {
                self.cUserNameToTitle.constant = 100
                self.view.layoutIfNeeded()
            }
        }
    }
    
    fileprivate func setMessageForSuccessPopup(_ isSuccess: Bool, _ successView: SuccessView) {
        if isSuccess {
            successView.lblTitle.text = "Congratulation".localized + "!"
            successView.lblMessage.text = "You have activated your account successfully".localized
        }else {
            successView.lblTitle.text = "Failed".localized + "!"
            successView.lblMessage.text = "Your account have not activated. Please try again".localized
        }
    }
    
    fileprivate func showError(isSuccess: Bool = true) {
        if let successView = view.viewWithTag(99) as? SuccessView {
            successView.isSuccess = isSuccess
            setMessageForSuccessPopup(isSuccess, successView)
            return
        }
        
        let successView = SuccessView(frame: viewNotification.frame)
        successView.tag = 99
        successView.isSuccess = isSuccess
        setMessageForSuccessPopup(isSuccess, successView)
        view.addSubview(successView)
    }
    
    func provisioningAccount(userName: String, smsCode: String) -> Bool {
        var isSuccess = false
        var deviceInfo: DeviceInfo? = nil
        var accountInfo: AccountInfo? = nil
        var otpInfo: OtpInfo? = nil
        var account: Account? = nil
        
        let hid = UIDevice.current.identifierForVendor?.uuidString ?? ""
        let os = "iOS" + UIDevice.current.model
        let uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""
        let systemVersion = UIDevice.current.systemName
        let notificationTokenId = currentDeviceToken
        
        let securityDevice = PinAuthentication()
        let passcode = accountVM.getPassCode()
        do {
            try securityDevice.setPinWithPin(passcode)
            try securityDevice.authenticate(with: passcode as NSObject)
        } catch let error {
            debugPrint(error.localizedDescription)
            return false
        }
        let clientId = userName
        let activationCode = smsCode
        
        let accountService = AccountService()
        let sessionInfo: SessionInfo
        do {
            try sessionInfo = accountService.onlineProvisioning(withUsername: clientId, sms: activationCode)
        } catch let error {
            debugPrint(error.localizedDescription)
            return false
        }
        
        var bindInfo: BindInfo? = nil
        do {
            try bindInfo = accountService.bindComplete(with: sessionInfo, hid: hid, deviceAuth: securityDevice, deviceToken: notificationTokenId, imei: uuid, os: os, model: systemVersion, deviceInfo: deviceInfo)
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        if bindInfo != nil {
            accountVM.saveDeviceInfoData(devInfo: bindInfo!.deviceInfo)
        }
        
        if let bindInfo = bindInfo, bindInfo.account.accountInfo.otpEnable {
            do {
                try accountService.updateBindCompleteStatus(with: sessionInfo, hid: hid, accountInfo: bindInfo.account.accountInfo, otpInfo: bindInfo.account.otpInfo, deviceAuth: securityDevice)
                    accountInfo = bindInfo.account.accountInfo
                    otpInfo = bindInfo.account.otpInfo
                    deviceInfo = bindInfo.deviceInfo
                    account = bindInfo.account
                    
                    if let otpInfo = otpInfo {
                        accountVM.saveOtpInfoData(otpInfo)
                    }
                    if let accountInfo = accountInfo {
                        accountVM.saveOtpAccountData(accountInfo)
                    }
                    
                    isSuccess = true
            }catch let error {
                debugPrint(error.localizedDescription)
            }
        }else if let bindInfo = bindInfo {
            do {
                try accountService.updateBindStatus(with: sessionInfo, accountInfo: bindInfo.account.accountInfo, deviceAuth: securityDevice)
                accountInfo = bindInfo.account.accountInfo
                accountInfo?.displayName = accountInfo?.companyName
                account?.accountInfo = accountInfo
            }catch let error {
                debugPrint(error.localizedDescription)
            }
        }
        
        return isSuccess
    }
    
    // MARK: - User Interactions
    @IBAction func getActivationCode(_ sender: Any) {
        showError(isSuccess: false)
    }
    
    @IBAction func doActive(_ sender: Any) {
        let code = txtActivateCodes.sorted(by: { (txt1, txt2) -> Bool in
            return txt1.tag < txt2.tag
        }).map { $0.text! }.joined(separator: "")
        debugPrint(code)
        if provisioningAccount(userName: txtAccountName.text ?? "", smsCode: code) {
            showError(isSuccess: true)
            self.view.endEditing(true)
            self.view.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.accountVM.getSyncOtpStatus()
//                self.navigationController?.popToRootViewController(animated: true)
                let app = UIApplication.shared.delegate as! AppDelegate
                let vc  = UIStoryboard(name: "MainNew", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
                app.window!.rootViewController = vc
            }
        }else {
            if let _ = view.viewWithTag(99) as? SuccessView {
                return
            }
            
            let successView = SuccessView(frame: viewNotification.frame)
            successView.tag = 99
            successView.isSuccess = false
            successView.lblMessage.text = "Your account have not activated. Please try again".localized
            title = "Setting PIN Failed".localized
            self.view.addSubview(successView)
        }
    }
    
    @IBAction func setLanguage(_ sender: UIButton) {
        btnLanguages.forEach { (btn) in
            if btn.tag == sender.tag {
                btn.titleLabel?.font =  UIFont(name: "PoppinsVN-600", size: 12)
                btn.setTitleColor(.black, for: .normal)
            }else {
                btn.titleLabel?.font =  UIFont(name: "PoppinsVN-300", size: 12)
                btn.setTitleColor(UIColor("D4D3D3"), for: .normal)
            }
        }
        
        if sender.tag == 1 {
            Utility.setLanguage(languageCode: "vi")
        }else {
            Utility.setLanguage(languageCode: "en")
        }
        
        fetchTextContent()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
//        if segue.identifier == "segNumPadsVC" {
//            let destVC = segue.destination as? CustomKeyboardViewController
//        }
    }
    

}

extension ActivateAccountViewController: OCBTextFieldDelegate {
    
    func textFieldDidDelete(textField: OCBTextField) {
        debugPrint("DELETE when empty")
        if textField.tag > 0 {
            txtActivateCodes.first { (txtF) -> Bool in
                txtF.tag == textField.tag - 1
                }?.becomeFirstResponder()
        }
    }
}

extension ActivateAccountViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if isBackSpace == -92 {
            print("Backspace was pressed", textField.tag)
            textField.text = ""
            if textField.tag > 0 {
                txtActivateCodes.first { (txtF) -> Bool in
                    txtF.tag == textField.tag - 1
                    }?.becomeFirstResponder()
            }
            return false
        }
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        if newLength > 1 {
            if textField.tag < txtActivateCodes.count - 1 {
                let txt = txtActivateCodes.first { (txtF) -> Bool in
                    txtF.tag == textField.tag + 1
                }
                
                txt?.becomeFirstResponder()
                txt?.text = string
            }
            return false
        }
        if string != "" {
            if textField.tag <= txtActivateCodes.count - 1 {
                let txt = txtActivateCodes.first { (txtF) -> Bool in
                    txtF.tag == textField.tag + 1
                }
                
                txt?.becomeFirstResponder()
                textField.text = string
            }
            return false
        }
        return newLength <= 1
    }
}
