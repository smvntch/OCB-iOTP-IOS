//
//  CustomNavigationViewController.swift
//  OCBiOTP
//
//  Created by Trinh Quang Son on 11/12/18.
//  Copyright © 2018 sontq00787@gmail.com. All rights reserved.
//

import UIKit

class CustomNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "navigation_bg"), for: .default)
//        self.navigationBar.shadowImage = #imageLiteral(resourceName: "image_navbar_bg")
        self.navigationBar.shadowImage = #imageLiteral(resourceName: "image_navbar_shadow")
        self.navigationBar.isTranslucent = true
        let textAttributes = [NSAttributedString.Key.foregroundColor: AppColors.commonGreen,
                              NSAttributedString.Key.font           : UIFont(name: "PoppinsVN-500", size: 18.0)]
        self.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle{
//        return .lightContent
//    }

}
