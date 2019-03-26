//
//  Extensions.swift
//  OCBiOTP
//
//  Created by Trinh Quang Son on 11/12/18.
//  Copyright © 2018 sontq00787@gmail.com. All rights reserved.
//

import Foundation
import UIKit

//let appLanguageKey = "AppleLanguages"
let appLanguageKey = "AppLanguage"
extension String {
    
    var localized: String {
//        return NSLocalizedString(self, comment: "")
        
        if let _ = UserDefaults.standard.string(forKey: appLanguageKey) {} else {
            UserDefaults.standard.set("en", forKey: appLanguageKey)
            UserDefaults.standard.synchronize()
        }
        
        let lang = UserDefaults.standard.string(forKey: appLanguageKey)
        
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        if let path = path {
            let bundle = Bundle(path: path)
            return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        }
        return NSLocalizedString(self, comment: "")
    }
}

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}

extension UIButton {
    
    @IBInspectable var localizedText: String? {
        get {
            return nil
        }
        set(key) {
            setTitle(titleLabel?.text?.localized, for: .normal)
        }
    }
}

extension UILabel {
    @IBInspectable var localizedText: String? {
        get {
            return nil
        }
        set(key) {
            text = key?.localized
        }
    }
//    func localized(string: String = "") {
//        debugPrint("SET TEXT", text)
//        text = string == "" ? text?.localized : string.localized
//    }
}

// MARK: - UIView
extension UIView {
    
    func roundCorner(color: UIColor, radius: CGFloat = 5) {
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = radius
    }
    
    func makeGradient(colors: [CGColor] = [UIColor("feaf2c").cgColor, UIColor("ee9502").cgColor], startPoint: CGPoint = CGPoint(x: 0, y: 1), endPoint: CGPoint = CGPoint(x: 1, y: 1), radius: CGFloat = 5) {
        DispatchQueue.main.async {
            let gradient = CAGradientLayer()
            gradient.frame = self.bounds
            gradient.colors = colors
            gradient.startPoint = startPoint
            gradient.endPoint = endPoint
            gradient.cornerRadius = radius
            self.layer.insertSublayer(gradient, at: 0)
        }
    }
    
    func makeShadow(radius: CGFloat = 5, offset: CGSize = .zero, shadowOpacity: Float? = 1, shadowColorAlpha: CGFloat = 0.1)  {
        self.layer.cornerRadius = radius
        self.layer.shadowColor = UIColor.black.withAlphaComponent(shadowColorAlpha).cgColor
        self.layer.shadowOpacity = shadowOpacity ?? 1
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
    }
    
    func clearShadow() {
        self.layer.shadowColor = UIColor.clear.cgColor
        self.layer.shadowOpacity = 0
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 0
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

// MARK: - UIColor
extension UIColor {
    
    convenience init(_ hex: UInt) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    convenience init(_ hexString: String) {
        let hexString: String = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        let scanner           = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
}

// MARK: - Notification
extension Notification.Name {
    
    static let messageKey = Notification.Name("onMessageReceived")
    static let handleMessageAfterLogin = Notification.Name("handleMessageAfterLogin")
    static let applicationWillEnterForeground = Notification.Name("applicationWillEnterForeground")
}
