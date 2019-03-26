//
//  SuccessView.swift
//  OCBiOTP
//
//  Created by Trinh Quang Son on 11/12/18.
//  Copyright © 2018 sontq00787@gmail.com. All rights reserved.
//

import UIKit

protocol SuccessViewDelegate {
    func didClosePopup()
}

class SuccessView: NibView {
    var isSuccess: Bool = true {
        didSet {
            if !isSuccess {
                lblTitle.text = "Failed".localized + "!"
                lblMessage.text = "Your PINs do not match. Please, try again".localized
                imgStatus.image = #imageLiteral(resourceName: "icon_warning")
                view.backgroundColor = UIColor("e51e09")
            }else {
                lblTitle.text = "Congratulation".localized + "!"
                lblMessage.text = "You have set PIN Code successfully".localized
                imgStatus.image = #imageLiteral(resourceName: "icon_circle_checked")
                view.backgroundColor = UIColor("008c44")
            }
        }
    }
    var delegate: SuccessViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.view.roundCorner(color: .clear, radius: 12)
        self.view.makeShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var imgStatus: UIImageView!
    
    @IBAction func close(_ sender: Any) {
        self.removeFromSuperview()
        if delegate != nil {
            delegate.didClosePopup()
        }
    }
}
