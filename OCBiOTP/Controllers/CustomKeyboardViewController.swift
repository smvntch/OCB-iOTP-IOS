//
//  CustomKeyboardViewController.swift
//  OCBiOTP
//
//  Created by Trinh Quang Son on 12/20/18.
//  Copyright © 2018 Finhay CoLtd. All rights reserved.
//

import UIKit

class CustomKeyboardViewController: UIViewController {
    @IBOutlet weak var cvNumpads: UICollectionView!
    
    let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
    var fullKeys: [Int]! = []
    
    let layout = UICollectionViewFlowLayout()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    // MARK: - Views
    fileprivate func initViews() {
        
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: (cvNumpads.bounds.width - 20) / 3, height: (cvNumpads.bounds.height - 25) / 4)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .vertical
        cvNumpads.collectionViewLayout = layout
        fullKeys.append(contentsOf: numbers)
        fullKeys.insert(-1, at: 9)
        fullKeys.insert(-2, at: 11)
        
//        updateIntputViews()
    }

}
//
//// MARK: - UICollectionViewDataSource
//extension CustomKeyboardViewController: UICollectionViewDataSource {
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return fullKeys.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "numberCell", for: indexPath)
//        let number = fullKeys[indexPath.row]
//        let lblNumer = cell.viewWithTag(1) as? UILabel
//        lblNumer?.isHidden = false
//        let imgBack = cell.viewWithTag(2) as? UIImageView
//        imgBack?.isHidden = true
//        let imgBackground = cell.viewWithTag(3) as? UIImageView
//        imgBackground?.isHidden = true
//        switch number {
//        case -2:
//            lblNumer?.isHidden = true
//            imgBack?.isHidden = false
//        //            imgBackground?.isHidden = true
//        case -1:
//            //            lblNumer?.isHidden = true
//            //            imgBackground?.isHidden = true
//            lblNumer?.text = "CLEAR".localized
//            lblNumer?.font = UIFont.systemFont(ofSize: 16)
//        default:
//            lblNumer?.text = "\(number)"
//            lblNumer?.font = UIFont.systemFont(ofSize: 28)
//        }
//        return cell
//    }
//}
//
//extension CustomKeyboardViewController: UICollectionViewDelegate {
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        if confirmNumbers.count < 6, fullKeys[indexPath.row] >= 0 {
////            confirmNumbers.append(fullKeys[indexPath.row])
////        }
//        
//        if indexPath.row == 9 {
////            confirmNumbers.removeAll()
//        }else if indexPath.row == 11 {
////            if confirmNumbers.count > 0 {
////                confirmNumbers.removeLast()
////            }
//        }
//        cvNumpads.cellForItem(at: indexPath)?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
//            self.cvNumpads.cellForItem(at: indexPath)?.backgroundColor = UIColor.white
//        }
//        
////        updateIntputViews()
//    }
//}
//
//extension CustomKeyboardViewController: UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: (cvNumpads.bounds.width - 20) / 3, height: (cvNumpads.bounds.height - 25) / 4)
//    }
//}
