//
//  TransactionDetailViewController.swift
//  OCBiOTP
//
//  Created by Trinh Quang Son on 11/15/18.
//  Copyright © 2018 sontq00787@gmail.com. All rights reserved.
//

import UIKit

class TransactionDetailViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var viewTransactionInformationGroup: UIView! {
        didSet {
            viewTransactionInformationGroup.makeShadow(radius: 5)
        }
    }
    @IBOutlet weak var viewOTPGroup: UIView! {
        didSet {
            viewOTPGroup.makeShadow(radius: 5)
        }
    }
    @IBOutlet var txtOTPs: [OCBTextField]! {
        didSet {
            txtOTPs.sort { (txt1, txt2) -> Bool in
                return txt1.tag < txt2.tag
            }
        }
    }
    @IBOutlet var lblTitles: [UILabel]!
    @IBOutlet var lblDatas: [UILabel]!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblSecurityCode: UILabel!
    @IBOutlet weak var lblTransactionID: UILabel!
    @IBOutlet weak var lblFromAccount: UILabel!
    @IBOutlet weak var lblToAccount: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var viewCountdown: UIView!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblCountdown: UILabel!
    
    // MARK: - Variables
    
    let timeLeftShapeLayer = CAShapeLayer()
    let bgShapeLayer = CAShapeLayer()
    var timeLeft: TimeInterval = 120
    var endTime: Date?
    var timer = Timer()
    // here you create your basic animation object to animate the strokeEnd
    let strokeIt = CABasicAnimation(keyPath: "strokeEnd")
    var generateCount = 1
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
        isOtpShowing = false
    }
    
    // MARK: - Views
    fileprivate func initViews() {
        title = "Transaction Approval".localized
        generateOTP()
        view.backgroundColor = UIColor(white: 0.94, alpha: 1.0)
        DispatchQueue.main.async {
            self.drawBgShape()
            self.drawTimeLeftShape()
        }
        
//        addTimeLabel()
        timeLeft = getTime()
        // here you define the fromValue, toValue and duration of your animation
        strokeIt.fromValue = (120 - timeLeft) / 120
        strokeIt.toValue = 1
        strokeIt.duration = timeLeft
        // add the animation to your timeLeftShapeLayer
        DispatchQueue.main.async {
            self.timeLeftShapeLayer.add(self.strokeIt, forKey: nil)
        }
        
        setCountdownTimer()
        
        lblTitles.forEach { lbl in lbl.text = ""}
        lblDatas.forEach { lbl in lbl.text = ""}
        if ocbNotification != nil {
            lblTitles.sort { (lbl1, lbl2) -> Bool in lbl1.tag < lbl2.tag }
            lblDatas.sort { (lbl1, lbl2) -> Bool in lbl1.tag < lbl2.tag }
            for i in 0..<ocbNotification.childs.count {
                if i < lblTitles.count {
                    let childData = ocbNotification.childs[i]
                    lblTitles[i].text = childData.caption.localized
                    lblDatas[i].text = childData.data
                    lblDatas[i].textColor = UIColor("\(childData.color ?? "000000")")
                    if childData.caption == "Amount" || childData.caption == "Số tiền" {
                        let amountString = NSMutableAttributedString(string: childData.data, attributes: [NSAttributedString.Key.foregroundColor: UIColor("\(childData.color ?? "000000")")])
                        amountString.append(NSAttributedString(string: " VNĐ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]))
                        lblDatas[i].attributedText = amountString
                    }
                }
            }
        }
    }
    
    fileprivate func getTime() -> Double {
        let commonService = CommonService()
        var timeServer: Date? = nil
        do {
            try timeServer = Date(timeIntervalSince1970:Double(commonService.getServerTime())!)
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ss"
        if let ts = timeServer {
            return 60 - (Double(dateFormatter.string(from: ts)) ?? 0) + 57
        }
        return 60 + 57
    }
    
    func drawBgShape() {
        bgShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: viewCountdown.center.x , y: viewCountdown.center.y), radius:
            viewCountdown.frame.height / 2, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        bgShapeLayer.strokeColor = UIColor("008c44").cgColor
        bgShapeLayer.fillColor = UIColor.clear.cgColor
        bgShapeLayer.lineWidth = 5
        viewOTPGroup.layer.addSublayer(bgShapeLayer)
    }
    
    func drawTimeLeftShape() {
        timeLeftShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: viewCountdown.center.x , y: viewCountdown.center.y), radius:
            viewCountdown.frame.height / 2, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        timeLeftShapeLayer.strokeColor = UIColor("ebebeb").cgColor
        timeLeftShapeLayer.fillColor = UIColor.clear.cgColor
        timeLeftShapeLayer.lineWidth = 5
        viewOTPGroup.layer.addSublayer(timeLeftShapeLayer)
    }

    // MARK: - Helpers
    fileprivate func setCountdownTimer() {
        // define the future end time by adding the timeLeft to now Date()
        endTime = Date().addingTimeInterval(timeLeft)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    fileprivate func fillOTP(_ otp: String) {
        let otpArr = Array(otp)
        var i = 0
        debugPrint(otp)
        txtOTPs.sorted { (txt1, txt2) -> Bool in
            return txt1.tag < txt2.tag
        }.forEach { (txt) in
            txt.text = String(otpArr[i])
            i += 1
        }
    }
    
    func generateOTP() {
        let otp = AccountViewModel().generateOTPForRegisteredUser()
        if otp == "Please register device".localized {
            Utility.showAlert(fromVC: self, message: otp)
            return
        }
        isOtpShowing = true
        fillOTP(otp)
    }
    
    @objc func updateTime() {
        if timeLeft > 0 {
            if timeLeft <= 15 {
                timeLeftShapeLayer.strokeColor = UIColor("ebebeb").cgColor
                timeLeftShapeLayer.fillColor = UIColor.clear.cgColor
                bgShapeLayer.strokeColor = UIColor.red.cgColor
                lblCountdown.textColor = .red
            }else {
                timeLeftShapeLayer.strokeColor = UIColor("ebebeb").cgColor
                timeLeftShapeLayer.fillColor = UIColor.clear.cgColor
                lblCountdown.textColor = UIColor("008c44")
            }
            
            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            lblCountdown.text = timeLeft.time
        } else {
            lblCountdown.text = "00"
            timer.invalidate()
            let alertVC = UIAlertController(title: "", message: "Time has expired".localized, preferredStyle: .alert)
            self.present(alertVC, animated: true) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    alertVC.dismiss(animated: true, completion: {
                        self.performSegue(withIdentifier: "segGoToHomeVC", sender: nil)
                    })
                }
            }
            return
        }
    }
    
    // MARK: - User Interactions
    @IBAction func doFinish(_ sender: Any) {
//        self.performSegue(withIdentifier: "segUnwindToHome", sender: nil)
        self.performSegue(withIdentifier: "segGoToHomeVC", sender: nil)
//        generateOTP()
    }
}


extension TimeInterval {
    
    var time: String {
        return String(format: self >= 100 ? "%03d":"%02d" , Int(self))
    }
}

extension Int {
    
    var degreesToRadians : CGFloat {
        return CGFloat(self) * .pi / 180
    }
}
