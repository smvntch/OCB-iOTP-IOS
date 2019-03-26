//
//  OCBTextField.swift
//  OCBiOTP
//
//  Created by Trinh Quang Son on 11/13/18.
//  Copyright © 2018 sontq00787@gmail.com. All rights reserved.
//

import UIKit

protocol OCBTextFieldDelegate{
    func textFieldDidDelete(textField: OCBTextField)
}

@IBDesignable
@objc class OCBTextField: UITextField {

    fileprivate var bottomLineView : UIView?
    var ocbTextDelegate: OCBTextFieldDelegate?
    /// Change Bottom Line Color.
    @IBInspectable open var lineColor : UIColor = UIColor.lightGray {
        didSet {
            updateBottomLineColor()
        }
    }
    
    // MARK:- Loading From NIB
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.initialize()
    }
    
    // MARK:- Intialization
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.initialize()
    }
    
    override func deleteBackward() {
        super.deleteBackward()
        ocbTextDelegate?.textFieldDidDelete(textField: self)
    }

}

fileprivate extension OCBTextField {
    
    func initialize() -> Void {
        self.clipsToBounds = true
        addBottomLine()
    }
    
    //MARK:- ADD Bottom Line
    func addBottomLine() {
        
        if bottomLineView?.superview != nil {
            return
        }
        //Bottom Line UIView Configuration.
        bottomLineView = UIView()
        bottomLineView?.backgroundColor = lineColor
        bottomLineView?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomLineView!)
        
        let leadingConstraint = NSLayoutConstraint.init(item: bottomLineView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint.init(item: bottomLineView!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint.init(item: bottomLineView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let bottomLineViewHeight = NSLayoutConstraint.init(item: bottomLineView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)
        
        self.addConstraints([leadingConstraint, trailingConstraint, bottomConstraint])
        bottomLineView?.addConstraint(bottomLineViewHeight)
    }
    
    func updateBottomLineColor(){
        bottomLineView?.backgroundColor = lineColor
    }
}
