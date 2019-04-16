//
//  HomeViewController.swift
//  OCBiOTP
//
//  Created by Trinh Quang Son on 11/14/18.
//  Copyright © 2018 sontq00787@gmail.com. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet var btnSetLanguages: [UIButton]! = []
    @IBOutlet weak var lblBottomMessage: UILabel!
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var lblTopMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        if isLogged == false{
            isLogged = true
            getPendingRequest()
        }

    }
    
    // MARK: - Views
    fileprivate func initViews() {
        let logo = #imageLiteral(resourceName: "icon_navbar_logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        Utility.setBtnLanguageState(buttons: btnSetLanguages)
        lblWelcome.text = "Welcome to OCB iOTP".localized
        lblTopMessage.text = "You don’t have any transaction need to verify.".localized
        let attributedText = NSMutableAttributedString(string: "OCB iOTP was built by OCB for securing your transaction based on the Policy of The State Bank of Viet Nam".localized + "\r\n" + "For more information, please".localized + " ")
        let attributedString = NSAttributedString(string: "click here".localized, attributes: [NSAttributedString.Key(rawValue: NSAttributedString.Key.underlineStyle.rawValue): 1, NSAttributedString.Key.foregroundColor: UIColor("E49717")])
        attributedText.append(attributedString)
        
        lblBottomMessage.attributedText = attributedText

        isInApp = true
       
       
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
        initViews()
    }
    
    private func getPendingRequest() {
     DispatchQueue.global(qos: .userInitiated).async {
        if let sessionCode = AccountViewModel().getPendingAuthentication(){
            let requestString: [String : Any] = [
                "sessioncode": sessionCode
            ]
            DispatchQueue.main.sync {
                NotificationCenter.default.post(name: .messageKey, object: nil,
                                                userInfo: requestString)
            }
            
            
        }
    }
    }
    // MARK: - Notification oberserver methods
    @objc func willEnterForeground() {
        print("will enter foreground")
        if isLogged == false{
            isLogged = true
            getPendingRequest()
        }
    }

    
    @IBAction func unwindToHome(segue:UIStoryboardSegue) { }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
