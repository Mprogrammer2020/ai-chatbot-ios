//
//  ChatVCExt.swift
//  ChatSupport
//
//  Created by netset on 13/06/23.
//

import UIKit
import Speech
import AVFoundation

extension ChatVC: ProtocolChatScreen {
    
    // MARK: Back Button Action
    func gotoBack() {
        self.popViewController(true)
    }
    
    func gotoSendMessage(_ textMsg: String) {
        if !textMsg.isBlank {
            let request = MessageModel(textMessage: textMsg,isSender: true)
            let requestEmpty = MessageModel(textMessage: "",isSender: false)
            objChatVM.arrMessages.append(request)
            objChatVM.arrMessages.append(requestEmpty)
            vwProperties.tblVwChat.reloadData()
            self.vwProperties.tblVwChat.scrollToBottom()
            vwProperties.txtVwMessage.text = ""
            vwProperties.txtVwMessage.resignFirstResponder()
            if objChatVM.isTextBasedChat {
                objChatVM.openAIMethod(textMsg) { (titleStr) in
                    DispatchQueue.main.async {
                        self.objChatVM.arrMessages[self.objChatVM.arrMessages.count - 1].textMessage += titleStr
                        UIView.animate(withDuration: 0.0001) {
                            self.vwProperties.tblVwChat.reloadRows(at: [IndexPath(row: self.objChatVM.arrMessages.count - 1, section: 0)], with: .none)
                        }
                        if titleStr == "" {
                            self.vwProperties.tblVwChat.scrollToBottom()
                            //if self.objChatVM.isFromAudio {
                                let text = self.objChatVM.arrMessages[self.objChatVM.arrMessages.count - 1].textMessage
                                if text != "" {
                                    debugPrint("Speech Text:- ",text)
                                    let string = text //"Tajinder is very good person.He has 10 girlfriends.He is very smart"
                                    let utterance = AVSpeechUtterance(string: string)
                                    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                                    utterance.rate = 0.3
                                    utterance.volume = 1
                                    let synth = AVSpeechSynthesizer()
                                    synth.speak(utterance)
                                    self.objChatVM.synth = synth
                                }
                          //  }
                        }
                    }
                }
            } else {
                objChatVM.openAIWithImageMethod(textMsg) { (arrCodes) in
                    if arrCodes.count > 0 {
                        for i in 0..<arrCodes.count {
                            let imageUrl = arrCodes[i].url
                            if i == 0 {
                                self.objChatVM.arrMessages[self.objChatVM.arrMessages.count - 1].textMessage = imageUrl
                            } else {
                                let requestEmpty = MessageModel(textMessage: imageUrl,isSender: false)
                                self.objChatVM.arrMessages.append(requestEmpty)
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.0001) {
                            self.vwProperties.tblVwChat.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    func gotoAudio(_ audioMsg: String) {
        if !audioMsg.isBlank {
            objChatVM.isFromAudio = true
            gotoSendMessage(audioMsg)
        }
    }
    
    func gotoUpdateValues() {
        if self.objChatVM.synth.isSpeaking {
            self.objChatVM.synth.stopSpeaking(at: .immediate)
        }
        self.objChatVM.isFromAudio = false
    }
}
