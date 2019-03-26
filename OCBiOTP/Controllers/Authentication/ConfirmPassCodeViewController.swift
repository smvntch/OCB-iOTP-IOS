//
//  PassCodeViewController.swift
//  OCBiOTP
//
//  Created by Trinh Quang Son on 11/12/18.
//  Copyright © 2018 sontq00787@gmail.com. All rights reserved.
//

import UIKit

class ConfirmPassCodeViewController: BaseViewController {
    // MARK: - Outlets
    @IBOutlet weak var viewNotification: UIView!
    @IBOutlet var viewInputs: [UIView]! = []
    @IBOutlet weak var btnContinue: UIButton! {
        didSet {
            btnContinue.makeGradient(colors: [UIColor("ffbb4b").cgColor, UIColor("e49717").cgColor], startPoint: CGPoint(x: 0, y: 1), endPoint: CGPoint(x: 1, y: 1), radius: 5)
        }
    }
    @IBOutlet weak var cvNumPads: UICollectionView!
    let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
    var fullKeys: [Int]! = []
    var inputNumbers: [Int]!
    var confirmNumbers: [Int]! = []
    // MARK: - Variables
    let layout = UICollectionViewFlowLayout()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    // MARK: - Views
    fileprivate func initViews() {
        title = "Confirm your PIN Code".localized
        
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: (cvNumPads.bounds.width - 20) / 3, height: (cvNumPads.bounds.height - 25) / 4)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .vertical
        cvNumPads.collectionViewLayout = layout
        fullKeys.append(contentsOf: numbers.shuffled())
        fullKeys.insert(-1, at: 9)
        fullKeys.insert(-2, at: 11)
        
        updateIntputViews()
    }
    
    fileprivate func updateIntputViews(isError: Bool = false) {
        viewInputs.forEach { (view) in
            if view.tag - 1 < confirmNumbers.count {
                view.backgroundColor = isError ? AppColors.commondRed: AppColors.commonGreen
                view.roundCorner(color: isError ? AppColors.commondRed: AppColors.commonGreen, radius: 7.5)
            }else {
                view.roundCorner(color: isError ? AppColors.commondRed: AppColors.commonGreen, radius: 7.5)
                view.backgroundColor = .white
            }
        }
    }
    
    // MARK: - User Interactions
    fileprivate func showNotificationPopup() {
        //FIXME: - Maybe should remove in real case
        if let successView = view.viewWithTag(99) as? SuccessView {
            successView.isSuccess = confirmNumbers == inputNumbers
            if !successView.isSuccess {
                updateIntputViews(isError: true)
                title = "Setting PIN Code Failed".localized
            }else {
                title = "Setting PIN Code Successfully".localized
                view.isUserInteractionEnabled = false
                Utility.setValueToLocal(confirmNumbers, AppPreferences.passCode)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.performSegue(withIdentifier: "segGoToLoginVC", sender: nil)
                }
            }
            return
        }
        
        let successView = SuccessView(frame: viewNotification.frame)
        successView.tag = 99
        if confirmNumbers != inputNumbers {
            debugPrint("WRONG!!!")
            successView.isSuccess = false
            updateIntputViews(isError: true)
            title = "Setting PIN Code Failed".localized
        }else {
            successView.isSuccess = true
            debugPrint("OK!!!")
            title = "Setting PIN Code Successfully".localized
            view.isUserInteractionEnabled = false
            Utility.setValueToLocal(confirmNumbers, AppPreferences.passCode)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.performSegue(withIdentifier: "segGoToLoginVC", sender: nil)
            }
        }
        self.view.addSubview(successView)
    }
    
    @IBAction func doContinue(_ sender: Any) {
        showNotificationPopup()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segGoToLoginVC" {
            segue.destination.navigationItem.hidesBackButton = true
        }
    }
    

}

// MARK: - UICollectionViewDataSource
extension ConfirmPassCodeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fullKeys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "numberCell", for: indexPath)
        let number = fullKeys[indexPath.row]
        let lblNumer = cell.viewWithTag(1) as? UILabel
        lblNumer?.isHidden = false
        let imgBack = cell.viewWithTag(2) as? UIImageView
        imgBack?.isHidden = true
        let imgBackground = cell.viewWithTag(3) as? UIImageView
        imgBackground?.isHidden = true
        switch number {
        case -2:
            lblNumer?.isHidden = true
            imgBack?.isHidden = false
//            imgBackground?.isHidden = true
        case -1:
//            lblNumer?.isHidden = true
//            imgBackground?.isHidden = true
            lblNumer?.text = "CLEAR".localized
            lblNumer?.font = UIFont.systemFont(ofSize: 16)
        default:
            lblNumer?.text = "\(number)"
            lblNumer?.font = UIFont.systemFont(ofSize: 28)
        }
        return cell
    }
}

extension ConfirmPassCodeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if confirmNumbers.count < 6, fullKeys[indexPath.row] >= 0 {
            confirmNumbers.append(fullKeys[indexPath.row])
        }
        
        if indexPath.row == 9 {
            confirmNumbers.removeAll()
        }else if indexPath.row == 11 {
            if confirmNumbers.count > 0 {
                confirmNumbers.removeLast()
            }
        }
        cvNumPads.cellForItem(at: indexPath)?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.cvNumPads.cellForItem(at: indexPath)?.backgroundColor = UIColor.white
        }

        updateIntputViews()
    }
}

extension ConfirmPassCodeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (cvNumPads.bounds.width - 20) / 3, height: (cvNumPads.bounds.height - 25) / 4)
    }
}
