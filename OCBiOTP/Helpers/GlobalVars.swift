//
//  GlobalVars.swift
//  OCBiOTP
//
//  Created by Trinh Quang Son on 11/12/18.
//  Copyright © 2018 sontq00787@gmail.com. All rights reserved.
//

import UIKit

class AppColors {
    
    static let commonGreen = UIColor("008c44")
    static let commondRed = UIColor("ed1c24")
}

struct AppPreferences {
    static let passCode = "passCode"
    static let useBiometric = "useBiometrics"
    static let useGPS = "useGPS"
    static let lockedTemp = "lockedTemp"
    static let lockedPrimary = "lockedPrimary"
    static let wrongCountAfterBanned = "wrongCountAfterBan"
}

struct AppConfigs {
    static let defaultServerEncKey  = "MIGbMBAGByqGSM49AgEGBSuBBAAjA4GGAAQAaLQrzzS99Z3R35Er94jFDmQIO5+UbPwB86Z0o4QVh7zvx71EJziKlBQesYXpjxJs7LYwFq5UEw7wKGKhAHwxX3YAohma7+RB9ij/lDEoZ6VHzaeTcfYbAnOIFbK71pvbIeODIZZ1F2Um9m6Mql3y/lqbM8Wp+mxUfzk+BbMLnpFXtaw="
    static let defaultServerSignKey = "MIGbMBAGByqGSM49AgEGBSuBBAAjA4GGAAQBnH7SMUUdyEsTdOHzew4XEegZnllZbeYtXgOPd4wYhrpNFrddncxUDg9JR+gE+yplRnaAlqQJ5Ca1WgBpzxTr5kwBFlqhWYSYmhfzu8ywNUBVRQC9ihTO7sJdh8uaROZCoYx1iLI3SUuZakueDqQYBHR7srm4ubU3qst/2EOJHzPcKCA="
    
    static let connectionTimeout: Int32   = 30
    static let loginRequestTimeout: Int32 = 120
    
    // MARK: - URL Config
   // static let baseUrl            = "https://office.securemetric.com:446"
    static let baseUrl            = "https://auth.phuongdongbank.vn"
  // static let baseUrl            = "https://iotp.ocb.com.vn"
    
    static let defaultSoftCertUrl = baseUrl + "/CentagateMobileWS/webresources/auth/secure/mobile/approveSoftCert/"
    static let defaultWSUrl       = baseUrl + "/CentagateMobileWS/webresources"
}

var ocbNotification: OCBNotification!
var currentDeviceToken: String!
var challengeCode: String! = ""
var isLogged = false
var isInApp = false
var isOtpShowing = false
var notificationData: NSNotification!
