//
//  SplashViewController.swift
//  OCBiOTP
//
//  Created by Trinh Quang Son on 12/10/18.
//  Copyright © 2018 sontq00787@gmail.com. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let app = UIApplication.shared.delegate as! AppDelegate
        let vc: UIViewController
        let storyboard = UIStoryboard(name: "MainNew", bundle: nil)
        if let _ = AccountViewModel().retriveOtpInfoData() {
            vc =  storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        }else {
            vc =  storyboard.instantiateViewController(withIdentifier: "ChooseLanguageViewController")
        }
        app.window!.rootViewController = vc
    }
}
