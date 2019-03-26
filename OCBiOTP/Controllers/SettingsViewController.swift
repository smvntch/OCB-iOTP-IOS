//
//  SettingsViewController.swift
//  OCBiOTP
//
//  Created by Trinh Quang Son on 11/20/18.
//  Copyright © 2018 sontq00787@gmail.com. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {
    @IBOutlet weak var viewDescription: UIView! {
        didSet {
            viewDescription.makeShadow()
        }
    }
    @IBOutlet weak var switchGPS: CustomSwitch! {
        didSet {
            setupSwitch(forSwitch: switchGPS)
        }
    }
    @IBOutlet weak var switchBiometric: CustomSwitch! {
        didSet {
            setupSwitch(forSwitch: switchBiometric)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "System Settings".localized
//        switchGPS.isOn = false
        switchBiometric.isOn = Utility.getValueFromLocal(key: AppPreferences.useBiometric) as? Bool ?? false
        switchGPS.isOn = Utility.getValueFromLocal(key: AppPreferences.useGPS) as? Bool ?? false
        setSwitchState(switchBiometric)
        setSwitchState(switchGPS)
//        switchGPS.isEnabled = false
    }
    
    fileprivate func setupSwitch(forSwitch: CustomSwitch) {
        forSwitch.isOn = false
        forSwitch.onTintColor = UIColor("2FAA33").withAlphaComponent(0.2)
        forSwitch.offTintColor = UIColor("ededed").withAlphaComponent(1)
        forSwitch.cornerRadius = 0.5
        forSwitch.thumbCornerRadius = 0.5
        forSwitch.thumbSize = CGSize(width: 25, height: 25)
        forSwitch.thumbTintColor = UIColor("2FAA33")
        forSwitch.padding = 0
        forSwitch.animationDuration = 0.25
    }
    
    fileprivate func setSwitchState(_ sender: CustomSwitch) {
        sender.thumbTintColor = sender.isOn ? UIColor("2FAA33") : UIColor("d40008")
    }
    
    @IBAction func toggleOnOff(_ sender: CustomSwitch) {
        setSwitchState(sender)
        if sender.tag == 1 {
            Utility.setValueToLocal(sender.isOn, AppPreferences.useBiometric)
        }else {
            Utility.setValueToLocal(sender.isOn, AppPreferences.useGPS)
            if sender.isOn {
//                if let bundleId = Bundle.main.bundleIdentifier,
//                    let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)")
//                {
//                    if #available(iOS 10.0, *) {
//                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                    } else {
//                        UIApplication.shared.openURL(URL(string: "prefs:root=LOCATION_SERVICES")!)
//                    }
//                }
                
                if #available(iOS 10.0, *) {
                    if let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION") {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                } else {
                    UIApplication.shared.openURL(URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION")!)
                }
            }
        }
    }
}
