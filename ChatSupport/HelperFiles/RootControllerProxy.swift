//
//  RootControllerProxy.swift
//  ChatSupport
//
//  Created by netset on 06/06/23.
//

import UIKit

class RootControllerProxy {
    
    static var shared: RootControllerProxy {
        return RootControllerProxy()
    }
    
    fileprivate init(){}
    
    // MARK: Set Root Without Drawer Method
    func rootWithoutDrawer(_ identifier: String,storyboard: Storyboards) {
        let blankController = getStoryboard(storyboard).instantiateViewController(withIdentifier: identifier)
        var homeNavController:UINavigationController = UINavigationController()
        homeNavController = UINavigationController.init(rootViewController: blankController)
        homeNavController.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = homeNavController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
}

// MARK: Get Storyboard
func getStoryboard(_ storyType:Storyboards) -> UIStoryboard {
    return UIStoryboard(name: storyType.rawValue, bundle: nil)
}

enum Storyboards: String {
    case main = "Main"
}

struct ResponseHandle {
    var data = Data(),
        JSON = NSDictionary(),
        message = String(),
        isSuccess = Bool(),
        statusCode = Int()
}
