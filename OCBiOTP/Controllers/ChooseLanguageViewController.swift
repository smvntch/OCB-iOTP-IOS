//
//  ChooseLanguageViewController.swift
//  OCBiOTP
//
//  Created by Trinh Quang Son on 11/12/18.
//  Copyright © 2018 sontq00787@gmail.com. All rights reserved.
//

import UIKit

class ChooseLanguageViewController: BaseViewController {
    
    @IBOutlet weak var btnVietnamese: UIButton! {
        didSet {
            btnVietnamese.makeGradient(colors: [UIColor("42ae00").cgColor, UIColor("0b9635").cgColor], startPoint: CGPoint(x: 0, y: 1), endPoint: CGPoint(x: 1, y: 1), radius: 5)
        }
    }
    @IBOutlet weak var btnEngLish: UIButton! {
        didSet {
            btnEngLish.makeGradient(colors: [UIColor("ffbb4b").cgColor, UIColor("e49717").cgColor], startPoint: CGPoint(x: 0, y: 1), endPoint: CGPoint(x: 1, y: 1), radius: 5)
        }
    }
    
    let accountVM = AccountViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let vc = UIStoryboard.init(name: "MainNew", bundle: Bundle.main).instantiateViewController(withIdentifier: "TransactionDetailViewController") as? TransactionDetailViewController
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
//    override func didReceiveRemoteNotification(notification: NSNotification) {
//        super.didReceiveRemoteNotification(notification: notification)
//        if let info = notification.userInfo as? [String:AnyObject] {
//            if let aps = info["aps"] as? [String:String] {
//                debugPrint(aps)
//            }
//            let sessionCode = info["sessionCode"] as? String ?? "123456"
//            let requestInfo = accountVM.getRequestInfo(requestId: sessionCode)
//            // TODO: - get displayMessage
//            if let displayMessage = requestInfo?.displayMessage {
//                accountVM.loadNotification(xmlDataString: displayMessage)
//                //            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
//                Utility.goToTransactionInfoVC(navigation: self.navigationController)
////                self.performSegue(withIdentifier: "segGoToTransactionInformationVC", sender: nil)
////                            }
//            }
//        } else {
//            print("Software failure.")
//        }
//    }
    
    @IBAction func doSetLanguage(_ sender: UIButton) {
        if ocbNotification != nil {
            self.performSegue(withIdentifier: "segGoToTransactionInformationVC", sender: nil)
            return
        }
        if sender.tag == 1 {
            Utility.setLanguage(languageCode: "vi")
        }else {
            Utility.setLanguage(languageCode: "en")
        }
        
        if let _ = accountVM.retriveOtpInfoData() {
            self.performSegue(withIdentifier: "segGoToLoginVC", sender: true)
        }else {
            self.performSegue(withIdentifier: "segGoToSetupPassCodeVC", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segGoToLoginVC" {
            let destVC = segue.destination as? LoginViewController
            destVC?.hasAddAccount = sender as? Bool ?? false
        }else if segue.identifier == "segGoToTransactionInformationVC" {
            let destVC = segue.destination as? TransactionInformationViewController
//            destVC?.ocbNotification = ocbNotification
        }
    }
    
}

