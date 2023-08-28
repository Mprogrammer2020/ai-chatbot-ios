//
//  HomeCategoryVC.swift
//  ChatSupport
//
//  Created by netset on 13/06/23.
//

import UIKit
import AVKit
import AVFoundation
import Speech

class HomeCategoryVC: UIViewController {
    
    // MARK: - @IBOutlets
    @IBOutlet var vwProperties: HomeCategoryProperties!
    
    // MARK: View Model Object
    var objHomeCategoryVM = HomeCategoryVM()
    private var dataSource: HomeCategoryDataSource!
    private var delegates: HomeCategoryDelegates!
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewDataSource()
    }
    
    //MARK: DataSource + Delegates
    private func initializeViewDataSource() {
        vwProperties.objHomeCategoryDelegate = self
        dataSource = HomeCategoryDataSource(viewModel: objHomeCategoryVM)
        delegates = HomeCategoryDelegates(viewModel: objHomeCategoryVM)
        vwProperties.colVWList.dataSource = dataSource
        vwProperties.colVWList.delegate = delegates
        vwProperties.colVWList.reloadData()
        delegates.callbackDidSelect = { (getIndex) in
            if getIndex == 0 {
                let chatviewcont = getStoryboard(.main).instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
                chatviewcont.objChatVM.isTextBasedChat = true
                chatviewcont.objChatVM.objHomeCategory = self.objHomeCategoryVM.arrHomeCategory[getIndex]
                self.navigationController?.pushViewController(chatviewcont, animated: true)
            } else if getIndex == 1 {
                let chatviewcont = getStoryboard(.main).instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
                chatviewcont.objChatVM.isTextBasedChat = false
                chatviewcont.objChatVM.objHomeCategory = self.objHomeCategoryVM.arrHomeCategory[getIndex]
                self.navigationController?.pushViewController(chatviewcont, animated: true)
            }
        }
    }
    
    
}
