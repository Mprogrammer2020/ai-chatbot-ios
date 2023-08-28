//
//  HomeCategoryProperties.swift
//  ChatSupport
//
//  Created by netset on 13/06/23.
//

import UIKit

protocol HomeCategoryDelegate {
    func gotoMenu()
}

class HomeCategoryProperties: UIView {
    
    // MARK: - @IBOutlets
    @IBOutlet var colVWList: UICollectionView!
    
    // MARK: Varibales
    var objHomeCategoryDelegate:HomeCategoryDelegate?
    
    // MARK: View Model Object
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: IBActions
    @IBAction func actionBtnMenu(_ sender: Any) {
        objHomeCategoryDelegate?.gotoMenu()
    }
    
}
