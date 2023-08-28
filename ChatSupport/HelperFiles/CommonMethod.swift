//
//  CommonMethod.swift
//  X-Vault
//
//  Created by netset on 09/12/22.
//

import UIKit

class CommonMethod {
    
    static var shared: CommonMethod {
        return CommonMethod()
    }
    fileprivate init(){}
    
    //MARK:- Show Activity Indicator Method
    func showActivityIndicator() {
        DispatchQueue.main.async {
            let activityData = ActivityData()
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        }
    }
    
    //MARK:- Hide Activity Indicator Method
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
    }
    
    
}
