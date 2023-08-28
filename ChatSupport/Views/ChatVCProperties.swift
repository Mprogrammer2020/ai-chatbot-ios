//
//  ChatVCProperties.swift
//  ChatSupport
//
//  Created by netset on 13/06/23.
//

import UIKit
import Speech
import InstantSearchVoiceOverlay

protocol ProtocolChatScreen {
    func gotoBack()
    func gotoSendMessage(_ textMsg: String)
    func gotoAudio(_ audioMsg: String)
    func gotoUpdateValues()
}

class ChatVCProperties: UIView {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var tblVwChat: UITableView!
    @IBOutlet weak var cnstHeightVwMessage: NSLayoutConstraint!
    @IBOutlet weak var vwMessage: UIView!
    @IBOutlet weak var txtVwMessage: IQTextView!
    @IBOutlet weak var btnAudio: UIButton!
    @IBOutlet weak var cnstBottomVwMessage: NSLayoutConstraint!
    @IBOutlet weak var lblDescriptChatType: UILabel!
    @IBOutlet weak var lblTitleChatType: UILabel!
    @IBOutlet weak var imgVwChatType: UIImageView!
    
    // MARK: Varibales
    var objProtocolChatScreen:ProtocolChatScreen?
    let voiceOverlayController = VoiceOverlayController()
    var currentCont = UIViewController()
    
    // MARK: View Model Object
    override func awakeFromNib() {
        super.awakeFromNib()
        btnAudio.addTarget(self, action: #selector(buttonLongPressed(_:)), for: .touchUpInside)
        voiceOverlayController.delegate = self
        voiceOverlayController.settings.autoStart = true
        voiceOverlayController.settings.autoStop = true
        voiceOverlayController.settings.showResultScreen = false
    }
    
    // MARK: IBActions
    @IBAction func actionBtnBack(_ sender: UIButton) {
        objProtocolChatScreen?.gotoUpdateValues()
        objProtocolChatScreen?.gotoBack()
    }
    
    @IBAction func actionBtnSendMessage(_ sender: Any) {
        objProtocolChatScreen?.gotoUpdateValues()
        objProtocolChatScreen?.gotoSendMessage(txtVwMessage.text ?? "")
    }
    
   // @objc func buttonLongPressed(_ sender: UILongPressGestureRecognizer) {
    @objc func buttonLongPressed(_ sender: UIButton) {
        objProtocolChatScreen?.gotoUpdateValues()
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            if authStatus == .authorized {
                self.configureSpeechToTextMethod()
            }
        }
    }
    
    // MARK: Set Chat Header Method
    func setChatHeaderMethod(_ objDetail:HomeCategory,viewConroller: UIViewController) {
        self.currentCont = viewConroller
        lblTitleChatType.text = objDetail.title
        lblDescriptChatType.text = objDetail.descript
        imgVwChatType.image = objDetail.image
    }
    
}
extension ChatVCProperties: VoiceOverlayDelegate {

    // MARK: Configure Speech To Text Method
    func configureSpeechToTextMethod() {
        DispatchQueue.main.async {
            self.voiceOverlayController.start(on: self.currentCont, textHandler: { (text, finalBool, extraInfo) in
                debugPrint("text:- ",text)
                debugPrint("finalBool:- ",finalBool)
                if finalBool {
                    self.objProtocolChatScreen?.gotoAudio(text)
                }
            }, errorHandler: { (error) in
                debugPrint("Callback: Error \(String(describing: error))")
            }, resultScreenHandler: { (text) in
                debugPrint("Result Screen: \(text)")
            })
        }
    }
    
    // Second way to listen to recording through delegate
    func recording(text: String?, final: Bool?, error: Error?) {
    }
    
}
