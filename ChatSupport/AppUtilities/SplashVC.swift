//
//  SplashVC.swift
//  ChatSupport
//
//  Created by netset on 06/06/23.
//

import UIKit

class SplashVC: UIViewController {
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboard()
        sleep(2)
        RootControllerProxy.shared.rootWithoutDrawer("HomeCategoryVC", storyboard: .main)
    }
    
    // MARK: Setup Keyboard Method
    private func setupKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.shouldToolbarUsesTextFieldTintColor = false
    }
    
}

