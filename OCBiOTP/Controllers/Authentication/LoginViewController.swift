//
//  LoginViewController.swift
//  OCBiOTP
//
//  Created by Trinh Quang Son on 11/14/18.
//  Copyright © 2018 sontq00787@gmail.com. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: BaseViewController {
    // MARK: - Outlets
    @IBOutlet var viewInputs: [UIView]! = []
    @IBOutlet weak var viewInputStack: UIStackView!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var cvNumPads: UICollectionView!
    @IBOutlet var btnSetLanguages: [UIButton]! = []
    @IBOutlet weak var viewNotification: UIView!
    @IBOutlet weak var lblSecurityNotice: UILabel!
    @IBOutlet weak var lblEnterPasscode: UILabel!
    
    
    // MARK: - Variables
    var isProcessTransaction: Bool! = false
    let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
    var fullKeys: [Int]! = []
    var inputNumbers: [Int]! = []
    let layout = UICollectionViewFlowLayout()
    
    var accountVM = AccountViewModel()
    var hasAddAccount = AccountViewModel().retriveOtpInfoData() != nil
    
    var wrongCount = 0
    var wrongCountAfterBan = 0
    var currentNotification: NSNotification!
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground(notification:)), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        inputNumbers.removeAll()
        updateIntputViews()
        if let date = Utility.getValueFromLocal(key: AppPreferences.lockedTemp) as? Date {
            debugPrint("Your account has been locked to \(date), can't use biometrics")
        }else {
            if let useBiometrics = Utility.getValueFromLocal(key: AppPreferences.useBiometric) as? Bool, useBiometrics {
                authenticateByBiometric(Utility.biometricType())
            }
        }
    }
    
    override func didReceiveRemoteNotification(notification: NSNotification) {
        super.didReceiveRemoteNotification(notification: notification)
        currentNotification = notification
    }
    
//    @objc func didReceiveTransactionNotification(notification: NSNotification) {
//        debugPrint("didReceiveRemoteNotification called")
////        isProcessTransaction = true
//        currentNotification = notification
//    }
    
    @objc func appWillEnterForeground(notification: NSNotification) {
        debugPrint("didReceiveRemoteNotification called")
        if let useBiometrics = Utility.getValueFromLocal(key: AppPreferences.useBiometric) as? Bool, useBiometrics {
            authenticateByBiometric(Utility.biometricType())
        }
    }
    
    // MARK: - Views
    fileprivate func fetchTextContent() {
        title = ocbNotification != nil ? "Application verification".localized: "Login".localized
        lblEnterPasscode.text = "Enter your PIN Code".localized
        lblSecurityNotice.text = "For security reasons, the numpad layout is randomized".localized
        cvNumPads.reloadData()
    }
    
    fileprivate func initViews() {
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: (cvNumPads.bounds.width - 20) / 3, height: (cvNumPads.bounds.height - 25) / 4)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .vertical
        cvNumPads.collectionViewLayout = layout
        fullKeys.append(contentsOf: numbers.shuffled())
        fullKeys.insert(-1, at: 9)
        fullKeys.insert(-2, at: 11)
        
        updateIntputViews()
        Utility.setBtnLanguageState(buttons: btnSetLanguages)
        fetchTextContent()
    }
    
    fileprivate func updateIntputViews(isError: Bool = false) {
        viewInputs.forEach { (view) in
            if view.tag - 1 < inputNumbers.count {
                view.backgroundColor = isError ? AppColors.commondRed: AppColors.commonGreen
                view.roundCorner(color: isError ? AppColors.commondRed: AppColors.commonGreen, radius: 7.5)
            }else {
                view.roundCorner(color: isError ? AppColors.commondRed: AppColors.commonGreen, radius: 7.5)
                view.backgroundColor = .white
            }
        }
    }
    
    // MARK: - Helpers
    fileprivate func wrongInput() {
        fullKeys.removeAll()
        fullKeys.append(contentsOf: numbers.shuffled())
        fullKeys.insert(-1, at: 9)
        fullKeys.insert(-2, at: 11)
        cvNumPads.reloadData()
        viewInputStack.shake()
        inputNumbers.removeAll()
        updateIntputViews()
        if hasAddAccount {
            
            if Utility.getValueFromLocal(key: AppPreferences.lockedTemp) != nil {
                if let wrongCountAfterBanned = Utility.getValueFromLocal(key: AppPreferences.wrongCountAfterBanned) as? Int {
                    wrongCountAfterBan = wrongCountAfterBanned + 1
                    if wrongCountAfterBan >= 2 {
                        Utility.setValueToLocal(true, AppPreferences.lockedPrimary)
                        let _ = checkAccountBanned()
                    }
                }else {
                    wrongCountAfterBan = 1
                }
                Utility.setValueToLocal(wrongCountAfterBan, AppPreferences.wrongCountAfterBanned)
            } else {
                wrongCount += 1
                if wrongCount >= 3 {
                    if Utility.getValueFromLocal(key: AppPreferences.lockedTemp) == nil {
                        Utility.setValueToLocal(Date().addingTimeInterval(300), AppPreferences.lockedTemp)
                        let _ = checkAccountBanned()
                    }
                }
            }
        }
    }
    
    fileprivate func isValidPassCode() -> Bool {
        if inputNumbers.count < 6 {
            return false
        }
        if let pincode = Utility.getValueFromLocal(key: AppPreferences.passCode) as? [Int] {
            return pincode == inputNumbers
        }
        return false
    }
    
    fileprivate func authenticateByBiometric(_ biometricType: Utility.BiometricType) {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = biometricType == .face ? "Using_FaceID_Reason" : "Using_TouchID_Reason".localized
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, error) in
                if success {
                    debugPrint("Success")
                    if self.checkAccountBanned() {
                        return
                    }
                    isLogged = true
                    self.wrongCount = 0
                    UserDefaults.standard.removeObject(forKey: AppPreferences.lockedTemp)
                    if let notiPopup = self.view.viewWithTag(99) as? SuccessView {
                        notiPopup.removeFromSuperview()
                    }
//                    self.fillAllInputViews()
                    DispatchQueue.main.async {
                        if self.currentNotification != nil {
                            self.handleNotification(self.currentNotification)
                            self.currentNotification = nil
                        }else {
                            self.processToNextVC()
                        }
                    }
                }else {
                    // do nothing
                    debugPrint("Unsuccess")
                }
            }
        }
    }
    
    fileprivate func checkAccountBanned() -> Bool {
        if let _ = Utility.getValueFromLocal(key: AppPreferences.lockedPrimary) {
            Utility.showAlert(fromVC: self, message: "Your account has locked on OCB iOTP. Please go to OCB Branches or call at 18006678 for help".localized)
            return true
        }
        if let date = Utility.getValueFromLocal(key: AppPreferences.lockedTemp) as? Date, date > Date() {
            debugPrint("Your account has been locked to \(date)")
            Utility.showAlert(fromVC: self, message: "Your account has locked for".localized + " \(Int(date.timeIntervalSinceNow)) " + "seconds".localized)
            return true
        }
        return false
    }
    
    fileprivate func processToNextVC() {
        if isProcessTransaction {
            self.performSegue(withIdentifier: "segGoToTransactionDetailVC", sender: nil)
        }else {
            if hasAddAccount {
                self.performSegue(withIdentifier: "segGoToHomeVC", sender: nil)
            }else {
                self.performSegue(withIdentifier: "segGoToActiveVC", sender: nil)
            }
        }
    }
    
    // MARK: - User Interactions
    @IBAction func doContinue(_ sender: Any) {
    }
    
    @IBAction func doSetLanguage(_ sender: UIButton) {
        btnSetLanguages.forEach { (btn) in
            if btn.tag == sender.tag {
                btn.titleLabel?.font =  UIFont(name: "PoppinsVN-600", size: 12)
                btn.setTitleColor(.black, for: .normal)
            }else {
                btn.titleLabel?.font =  UIFont(name: "PoppinsVN-300", size: 12)
                btn.setTitleColor(UIColor("D4D3D3"), for: .normal)
            }
        }
        if sender.tag == 1 {
            //set language to VN
            Utility.setLanguage(languageCode: "vi")
        }else {
            //set language to ENG
            Utility.setLanguage(languageCode: "en")
        }
        
        fetchTextContent()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "segGoToConfirmPassCodeVC" {
//            let destVC = segue.destination as? ConfirmPassCodeViewController
//            destVC?.inputNumbers = inputNumbers
//        }
        if segue.identifier == "segGoToTransactionDetailVC" {
            let destVC = segue.destination as? TransactionInformationViewController
        }
    }
    
    
}

// MARK: - UICollectionViewDataSource
extension LoginViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fullKeys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "numberCell", for: indexPath)
        let number = fullKeys[indexPath.row]
        let lblNumer = cell.viewWithTag(1) as? UILabel
        lblNumer?.isHidden = false
        let imgBack = cell.viewWithTag(2) as? UIImageView
        imgBack?.isHidden = true
        let imgBackground = cell.viewWithTag(3) as? UIImageView
        imgBackground?.isHidden = true
        switch number {
        case -2:
            lblNumer?.isHidden = true
            imgBack?.isHidden = false
//            imgBackground?.isHidden = true
        case -1:
//            lblNumer?.isHidden = true
//            imgBackground?.isHidden = true
            lblNumer?.text = "CLEAR".localized
            lblNumer?.font = UIFont.systemFont(ofSize: 16)
        default:
            lblNumer?.text = "\(number)"
            lblNumer?.font = UIFont.systemFont(ofSize: 28)
        }
        return cell
    }
}

extension LoginViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if inputNumbers.count < 6, fullKeys[indexPath.row] >= 0 {
            inputNumbers.append(fullKeys[indexPath.row])
        }
        
        if indexPath.row == 9 {
            inputNumbers.removeAll()
        }else if indexPath.row == 11 {
            if inputNumbers.count > 0 {
                inputNumbers.removeLast()
            }
        }
        cvNumPads.cellForItem(at: indexPath)?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.cvNumPads.cellForItem(at: indexPath)?.backgroundColor = UIColor.white
        }

        updateIntputViews()
        
        if inputNumbers.count == 6 {
            if checkAccountBanned() {
                return
            }
            if isValidPassCode() {
                isLogged = true
                wrongCount = 0
                UserDefaults.standard.removeObject(forKey: AppPreferences.lockedTemp)
                if let notiPopup = view.viewWithTag(99) as? SuccessView {
                    notiPopup.removeFromSuperview()
                }
                if self.currentNotification != nil {
                    self.handleNotification(currentNotification)
                    self.currentNotification = nil
                }else {
                    self.processToNextVC()
                }
            }else {
                cvNumPads.cellForItem(at: indexPath)?.backgroundColor = UIColor.white
                wrongInput()
                if let _ = view.viewWithTag(99) as? SuccessView {
                    return
                }
                
                let successView = SuccessView(frame: viewNotification.frame)
                successView.tag = 99
                successView.isSuccess = false
                successView.delegate = self
                updateIntputViews(isError: true)
                title = "Login".localized
                self.view.addSubview(successView)
            }
        }
    }
}

extension LoginViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (cvNumPads.bounds.width - 20) / 3, height: (cvNumPads.bounds.height - 25) / 4)
    }
}

extension LoginViewController: SuccessViewDelegate {
    
    func didClosePopup() {
        inputNumbers.removeAll()
        updateIntputViews()
    }
}
