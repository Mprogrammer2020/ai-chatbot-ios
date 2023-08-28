//
//  ChatVM.swift
//  ChatSupport
//
//  Created by netset on 13/06/23.
//

import Foundation
import OpenAI
import Speech

struct MessageModel {
    
    var textMessage = String()
    var isSender = Bool()
    
}

class ChatVM {
    
    // MARK: Varibales
    var arrMessages = [MessageModel]()
    var isTextBasedChat = Bool()
    var objHomeCategory = HomeCategory()
    var synth = AVSpeechSynthesizer()
    var isFromAudio = Bool()
    
    // MARK: Open AI Method
    func openAIMethod(_ textStr: String,completion:@escaping(_ codeStr:String) -> Void) {
        let configuration = OpenAI.Configuration(token: "OPEN-AI-Key")
        let configurationOpenAI = OpenAI(configuration: configuration)
        let chatObject = Chat(role: .system, content: textStr)
        let chatQuery = ChatQuery(model: "MODEL-NAME", messages: [chatObject])
        configurationOpenAI.chatsStream(query: chatQuery) { result in
            if (result.success?.choices.count ?? 0) > 0 {
                let str = result.success?.choices[0].delta.content ?? ""
                debugPrint("Result String:- ",str)
                completion(str)
            }
        } completion: { error in
            debugPrint("error",error?.localizedDescription ?? "")
        }
    }
    
    // MARK: Open AI With Image Method
    func openAIWithImageMethod(_ textStr: String,completion:@escaping(_ arrCodes:[ImagesResult.URLResult]) -> Void) {
        let configuration = OpenAI.Configuration(token: "OPEN-AI-Key")
        let configurationOpenAI = OpenAI(configuration: configuration)
        configurationOpenAI.images(query: ImagesQuery(prompt: textStr, n: 3, size: "1024x1024")) { (result) in
            debugPrint("Image String:- ",result.success?.data ?? [])
            completion(result.success?.data ?? [])
        }
    }
}
