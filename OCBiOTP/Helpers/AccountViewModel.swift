//
//  AccountViewModel.swift
//  OCBiOTP
//
//  Created by Trinh Quang Son on 12/4/18.
//  Copyright © 2018 sontq00787@gmail.com. All rights reserved.
//

import UIKit

class AccountViewModel: NSObject {
    var isParseDone = false
    var currentLanguage = "en"
    let parentKeys = ["Field1", "Field2", "Field3", "Field4", "Field5"]
    let keys: [String] = ["Caption", "Data", "Color"]
    var rootKey = "EN"
    var eName = ""
    var caption = ""
    var data = ""
    var color = ""

    func saveDeviceInfoData(devInfo: DeviceInfo) {
        let dic = ["devSignKey": devInfo.deviceCipherSignKey,
                   "devEncKey" : devInfo.deviceCipherEncKey] as [String: String]
        //                Utility.setValueToLocal(dic, "devInfo")
        
        Utility.setValueToLocal(dic, "devInfo")
    }
    
    func retriveDeviceInfo() -> DeviceInfo? {
        if let dic = Utility.getValueFromLocal(key: "devInfo") as? [String: String] {
            let devInfo = DeviceInfo()
            devInfo.deviceCipherEncKey = dic["devEncKey"]
            devInfo.deviceCipherSignKey = dic["devSignKey"]
            return devInfo
        }
        return  nil
    }
    
    func saveOtpInfoData(_ otpInfo: OtpInfo) {
        var dic = [String: String]()
        let otpSerialNumber = otpInfo.otpSerialNumber.count > 0 ? otpInfo.otpSerialNumber : "NIL"
        dic["otpSerialNumber"] = otpSerialNumber
        dic["otpSignAlgo"] = otpInfo.otpSignAlgo
        dic["otpCsvAlgo"] = otpInfo.otpCsvAlgo
        dic["otpCrAlgo"] = otpInfo.otpCrAlgo
        dic["cipherOtpSeed"] = otpInfo.cipherOtpSeed
        dic["randomData"] = otpInfo.randomData
        dic["otpGap"] = "\(otpInfo.otpGap)"
        Utility.setValueToLocal(dic, "otpInfo")
    }
    
    func retriveOtpInfoData() -> OtpInfo? {
        if let dic = Utility.getValueFromLocal(key: "otpInfo") as? [String: String] {
            let otpInfo = OtpInfo()
            otpInfo.otpSerialNumber = dic["otpSerialNumber"]
            otpInfo.otpSignAlgo = dic["otpSignAlgo"]
            otpInfo.otpCsvAlgo = dic["otpCsvAlgo"]
            otpInfo.otpCrAlgo = dic["otpCrAlgo"]
            otpInfo.cipherOtpSeed = dic["cipherOtpSeed"]
            otpInfo.randomData = dic["randomData"]
            otpInfo.otpGap = Int(dic["otpGap"] ?? "0") ?? 0
            return otpInfo
        }
        return nil
    }
    
    func saveOtpAccountData(_ accountInfo: AccountInfo) {
        var dic = [String: String]()
        dic["accountId"] = accountInfo.accountId
        dic["username"] = accountInfo.username
        dic["displayName"] = accountInfo.displayName
        dic["firstName"] = accountInfo.firstName
        dic["lastName"] = accountInfo.lastName
        dic["companyName"] = accountInfo.companyName
        dic["companyCountry"] = accountInfo.companyCountry
        dic["accountCipherEncKey"] = accountInfo.accountCipherEncKey
        dic["accountCipherSignKey"] = accountInfo.accountCipherSignKey
        dic["otpEnable"] = accountInfo.otpEnable ? "1": "0"
        dic["offline"] = accountInfo.offline ? "1" :"0"
        Utility.setValueToLocal(dic, "accountInfo")
    }
    
    func retriveAccountInfoData() -> AccountInfo? {
        if let dic = Utility.getValueFromLocal(key: "accountInfo") as? [String: String] {
            let accountInfo = AccountInfo()
            accountInfo.accountId = dic["accountId"]
            accountInfo.username = dic["username"]
            accountInfo.displayName = dic["displayName"]
            accountInfo.firstName = dic["firstName"]
            accountInfo.lastName = dic["lastName"]
            accountInfo.companyName = dic["companyName"]
            accountInfo.companyCountry = dic["companyCountry"]
            accountInfo.accountCipherEncKey = dic["accountCipherEncKey"]
            accountInfo.accountCipherSignKey = dic["accountCipherSignKey"]
            accountInfo.otpEnable = dic["otpEnable"] == "1" ? true: false
            accountInfo.offline = dic["offline"] == "1" ? true :false
            return accountInfo
        }
        
        return nil
    }
    
    func getAccountData() -> Account? {
        let account = Account()
        if let accountInfo = retriveAccountInfoData() {
            account.accountInfo = accountInfo
        } else {
            return nil
        }
        if let otpInfo = retriveOtpInfoData() {
            account.otpInfo = otpInfo
        } else {
            return nil
        }
        return account
    }
    
    func getPassCode() -> String {
        if let passcode = Utility.getValueFromLocal(key: AppPreferences.passCode) as? [Int] {
            return passcode.map { String($0) }.joined(separator: "")
        }
        return ""
    }
    
    func generateOTPForRegisteredUserTest(localChallengeCode: String) -> (String, String) {
        if let otpInfo = retriveOtpInfoData() {
            let securityDevice = PinAuthentication()
            let  otpOperation = OtpOperation()
            
            let otpTime: String
            let otpTime2: String
            do {
                try securityDevice.setPinWithPin(getPassCode())
                try securityDevice.authenticate(with: getPassCode() as NSObject)
                try otpTime = otpOperation.generateSignOtp(with: otpInfo, dataToSign: localChallengeCode, deviceAuthentication: securityDevice)
                try otpTime2 = otpOperation.generateTotp(with: otpInfo, deviceAuthentication: securityDevice)
                return (otpTime, otpTime2)
            }catch let error {
                debugPrint(error.localizedDescription)
            }
        }
        return ("Please register device".localized, "")
    }
    
    func generateOTPForRegisteredUser() -> String {
        if let otpInfo = retriveOtpInfoData() {
            let securityDevice = PinAuthentication()
            let  otpOperation = OtpOperation()
            
            let otpTime: String
            do {
                try securityDevice.setPinWithPin(getPassCode())
                try securityDevice.authenticate(with: getPassCode() as NSObject)
                debugPrint("Challenge Code:",challengeCode!)
                try otpTime = otpOperation.generateSignOtp(with: otpInfo, dataToSign: challengeCode!, deviceAuthentication: securityDevice)
//                try otpTime = otpOperation.generateSignOtp(with: otpInfo, dataToSign: "123456", deviceAuthentication: securityDevice)
//                try otpTime = otpOperation.generateCrOtp(with: otpInfo, challengeCode: challengeCode, deviceAuthentication: securityDevice)
//                try otpTime = otpOperation.generateTotp(with: otpInfo, date: Date(), deviceAuthentication: securityDevice)
                return otpTime
            }catch let error {
                debugPrint(error.localizedDescription)
            }
        }
        return "Please register device".localized
    }
    
    func getSyncOtpStatus() -> Bool {
        let otpService = OtpService()
        let hid = UIDevice.current.identifierForVendor?.uuidString ?? ""
        if let account = getAccountData() {
            let securityDevice = PinAuthentication()
            do {
                try securityDevice.setPinWithPin(getPassCode())
                try otpService.syncOtp(withHid: hid, account: account, deviceAuthentication: securityDevice)
            } catch let error {
                debugPrint(error.localizedDescription)
                return false
            }
        }
        debugPrint("sync done")
        return true
    }
    
    func getRequestInfo(requestId: String) -> RequestInfo? {
        let authenticateService = AuthenticationService()
        let securityDevice = PinAuthentication()
        let passcode = getPassCode()
        do {
            try securityDevice.setPinWithPin(passcode)
            try securityDevice.authenticate(with: passcode as NSObject)
            
            guard let accountInfo = retriveAccountInfoData() else {
                return nil
            }
            
            let requestInfo = try authenticateService.getRequestInfo(withHid: UIDevice.current.identifierForVendor?.uuidString ?? "", requestId: requestId, accountInfo: accountInfo, deviceAuthentication: securityDevice)
            return requestInfo
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        return nil
    }
    
    func getPendingAuthentication() -> String? {
        let authenticateService = AuthenticationService()
        let securityDevice = PinAuthentication()
        let passcode = getPassCode()
        
        do {
            try securityDevice.setPinWithPin(passcode)
            try securityDevice.authenticate(with: passcode as NSObject)
            
            guard let accountInfo = retriveAccountInfoData() else
            {
                return nil
            }
            let pendingArray = try authenticateService.getPendingRequestInfo(withHid: UIDevice.current.identifierForVendor?.uuidString ?? "", accountInfo: accountInfo, deviceAuthentication: securityDevice)
         
            let request : RequestInfo = pendingArray.object(at: 0) as! RequestInfo
          
            return request.requestId
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        return nil
    }
    
    func loadNotification(xmlDataString: String) {
        isParseDone = false
        ocbNotification = nil
        currentLanguage = Utility.getValueFromLocal(key: appLanguageKey) as? String ?? "en"
        parseXML(xmlString: xmlDataString)
    }
    
    func parseXML(xmlString: String) {
        let parser = XMLParser.init(data: xmlString.data(using: .utf8)!)
        parser.delegate = self
        parser.parse()
    }
    
    func getOtpSignChallangeMaxLength() -> Int {
        if let otpSignAlgo = retriveOtpInfoData()?.otpSignAlgo {
            debugPrint(otpSignAlgo)
            let otpSplitArr = otpSignAlgo.split(separator: Character(":"))
            if otpSplitArr.count < 3 {
                return 0
            }
            let stringContainMaxLength = otpSplitArr[2]
            return Int(String(stringContainMaxLength.split(separator: Character("-"))[0]).digits) ?? 0
        }
        return 0
    }
}

extension AccountViewModel: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        eName = elementName
        if currentLanguage == "en", elementName == "EN" {
            ocbNotification = OCBNotification()
        } else if currentLanguage == "en", elementName == "VN" {
            if ocbNotification != nil {
                isParseDone = true
            }
        } else if currentLanguage == "vi", elementName == "VN" {
            ocbNotification = OCBNotification()
        } else if currentLanguage == "vi", elementName == "EN" {
            if ocbNotification != nil {
                isParseDone = true
            }
        }
        
        if parentKeys.contains(elementName) {
            caption = ""
            data = ""
            color = ""
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
//        if keys.contains(elementName){
//            debugPrint(elementName)
//        }
        if parentKeys.contains(elementName) {
            var childData = NotificationChildData()
            childData.caption = caption
            childData.data = data
            childData.color = color
            if ocbNotification != nil, !isParseDone {
                ocbNotification.childs.append(childData)
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data1 = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if !data1.isEmpty {
//            debugPrint(data1)
            switch eName {
            case "Caption":
                caption += data1
            case "Data":
                data += data1
            case "Color":
                color += data1
            default:
                break
            }
        }
    }
}

extension String {
    
    func sha256() -> String{
        if let stringData = self.data(using: String.Encoding.utf8) {
            return hexStringFromData(input: digest(input: stringData as NSData))
        }
        return ""
    }
    
    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }
    
    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        
        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }
        
        return hexString
    }
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}
