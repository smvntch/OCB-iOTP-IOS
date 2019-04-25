//
//  TransactionInformationViewController.swift
//  OCBiOTP
//
//  Created by Trinh Quang Son on 11/15/18.
//  Copyright © 2018 sontq00787@gmail.com. All rights reserved.
//

import UIKit
import UserNotifications

class TransactionInformationViewController: BaseViewController {
    @IBOutlet weak var viewTransactionInformationGroup: UIView! {
        didSet {
            viewTransactionInformationGroup.makeShadow(radius: 5)
        }
    }
    @IBOutlet var lblTitles: [UILabel]!
    @IBOutlet var lblDatas: [UILabel]!
    var sessionCode = ""
    @IBOutlet weak var btnConfirm: UIButton! {
        didSet {
            btnConfirm.makeGradient(colors: [UIColor("42ae00").cgColor, UIColor("0b9635").cgColor], startPoint: CGPoint(x: 0, y: 1), endPoint: CGPoint(x: 1, y: 1), radius: 5)
        }
    }
    @IBOutlet weak var btnCancel: UIButton! {
        didSet {
            btnCancel.layer.cornerRadius = 5
        }
    }
    
//    var ocbNotification: OCBNotification!
    override func viewDidLoad() {
        super.viewDidLoad()
  
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.removeAllDeliveredNotifications() // To remove all delivered notifications
        } else {
            // Fallback on earlier versions
            UIApplication.shared.cancelAllLocalNotifications()
        }
        viewTransactionInformationGroup.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRequestInfo()
    }
    
    fileprivate func getRequestInfo(){
        if(challengeCode == "" && sessionCode != ""){
            
            let alert = UIAlertController(title: nil, message: " ", preferredStyle: .alert)
            
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.gray
            loadingIndicator.startAnimating();
            
            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true) {
                [weak self] in
                guard let code = self?.sessionCode else{
                    alert.dismiss(animated: true, completion: nil)
                    return;
                }
                if self?.getRequestInfo(sessionCode: code) != nil{
                    self?.initViews()
                    alert.dismiss(animated: true, completion: nil)
                }else{
                    alert.dismiss(animated: true, completion: {
                        
                        let alertController = UIAlertController(title: "", message: "Get request information failed. Please try again".localized, preferredStyle: .alert)
                    
                        let action1 = UIAlertAction(title: "Ok", style: .cancel) { (action:UIAlertAction) in
                            Utility.goToHomeVC(navigation: self?.navigationController)
                        }
                        alertController.addAction(action1)
                        self?.present(alertController, animated: true, completion: nil)
                    
                    })
                    debugPrint("error get request info sessionCode : \(code)")
                }
              
            }
            
        }else{
                  initViews()
        }
    }
    
    // MARK: - Views
    
    fileprivate func initViews() {
        viewTransactionInformationGroup.isHidden = false
        title = "Transaction Approval".localized
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
    
    // MARK: - User Interactions
    
    @IBAction func doConfirm(_ sender: Any) {
        DispatchQueue.global(qos: .userInitiated).async {
            AccountViewModel().getSyncOtpStatus()
        }
        if isLogged, !isInApp {
            self.performSegue(withIdentifier: "segGoToTransactionDetailVC", sender: nil)
        }else {
            self.performSegue(withIdentifier: "segGoToLoginVC", sender: nil)
        }
    }
    
    @IBAction func doCancel(_ sender: Any) {
        Utility.goToHomeVC(navigation: self.navigationController)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segGoToLoginVC" {
            let destVC = segue.destination as? LoginViewController
            destVC?.isProcessTransaction = true
        }else if segue.identifier == "segGoToTransactionDetailVC" {
            
        }
    }
    

}
