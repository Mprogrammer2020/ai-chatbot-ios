//
//  ChatVC.swift
//  ChatSupport
//
//  Created by netset on 13/06/23.
//

import UIKit

class ChatVC: UIViewController {
    
    // MARK: - @IBOutlets
    @IBOutlet var vwProperties: ChatVCProperties!
    
    // MARK: View Model Object
    var objChatVM = ChatVM()
    private var dataSource: ChatDataDataSource!
    private var delegates: ChatDataDelegates!
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewDataSource()
    }
    
    //MARK: DataSource + Delegates
    private func initializeViewDataSource() {
        vwProperties.setChatHeaderMethod(objChatVM.objHomeCategory, viewConroller: self)
        vwProperties.objProtocolChatScreen = self
        dataSource = ChatDataDataSource(viewModel: objChatVM)
        delegates = ChatDataDelegates(viewModel: objChatVM)
        vwProperties.tblVwChat.dataSource = dataSource
        vwProperties.tblVwChat.delegate = delegates
        vwProperties.tblVwChat.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        IQKeyboardManager.shared.enable = false
        startKeyboardObserver()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        IQKeyboardManager.shared.enable = true
        self.stopKeyboardObserver()
    }
    
    fileprivate func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    fileprivate func stopKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let userInfo = (notification as NSNotification).userInfo {
            let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
            vwProperties.cnstBottomVwMessage.constant = (frame.height - self.view.safeAreaInsets.bottom) + 15
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        vwProperties.cnstBottomVwMessage.constant = 15
    }
}
