//
//  HomeCategoryVM.swift
//  ChatSupport
//
//  Created by netset on 13/06/23.
//

import UIKit

struct HomeCategory {
    
    var title = String()
    var image = UIImage()
    var descript = String()
}
class HomeCategoryVM {
    
    var arrHomeCategory = [
        HomeCategory(title: "Text Based Chat",image: UIImage(named: "text-based-image")!,descript: "Keyboard-generated electronic chat that is simultaneously dialogic."),
        HomeCategory(title: "Image Based Chat",image: UIImage(named: "image-based-chat")!,descript: "Image based chat communicate through the exchange of visual content.")
    ]
}
