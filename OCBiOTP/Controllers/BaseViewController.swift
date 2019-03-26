//
//  BaseViewController.swift
//  OCBiOTP
//
//  Created by Trinh Quang Son on 11/12/18.
//  Copyright © 2018 sontq00787@gmail.com. All rights reserved.
//

import UIKit
import UserNotifications

class BaseViewController: UIViewController {
    deinit {
        NotificationCenter.default.removeObserver(self, name: .messageKey, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveRemoteNotification(notification:)), name: .messageKey, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "icon_back")
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "icon_back")
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "icon_navigation_back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "icon_navigation_back")
    }

    // MARK: - Notification Handler
    func handleNotification(_ notification: NSNotification) {
        if let info = notification.userInfo as? [String: AnyObject] {
            let sessionCode = info["sessioncode"] as? String ?? ""
            let accountVM = AccountViewModel()
            let requestInfo = accountVM.getRequestInfo(requestId: sessionCode)
            if let displayMessage = requestInfo?.displayMessage, let randomString = requestInfo?.randomString {
                debugPrint(displayMessage)
                challengeCode = (sessionCode + randomString.sha256()).digits
                debugPrint("GENERATE CHALLENGE CODE:", challengeCode!)
                let maxLength = accountVM.getOtpSignChallangeMaxLength()
                if maxLength > 0, maxLength < challengeCode.count {
                    challengeCode = String(challengeCode[..<challengeCode.index(challengeCode.startIndex, offsetBy: maxLength)])
                }
                accountVM.loadNotification(xmlDataString: displayMessage)
                if let _ = navigationController?.topViewController as? TransactionInformationViewController {
                    //do nothing
                }else {
                    Utility.goToTransactionInfoVC(navigation: self.navigationController)
                }
            }else {
                debugPrint("Cannot get display message")
                Utility.goToHomeVC(navigation: self.navigationController)
//                Utility.showAlert(fromVC: self, message: "")
            }
        } else {
            print("Software failure.")
        }
    }
    
    @objc func didReceiveRemoteNotification(notification: NSNotification) {
        debugPrint("didReceiveRemoteNotification called")
        notificationData = notification
        if isLogged {
            debugPrint("HANDLE FOR LOGGED STATE")
            handleNotification(notification)
        }else {
            debugPrint("HANDLE NOT LOGIN STATE")
            NotificationCenter.default.post(name: .handleMessageAfterLogin, object: notification)
        }
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension BaseViewController: UNUserNotificationCenterDelegate {
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}
