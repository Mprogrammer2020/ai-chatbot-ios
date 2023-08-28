//
//  StringExtension.swift
//  X-Vault
//
//  Created by netset on 09/12/22.
//

import UIKit
import SDWebImage

extension String {
    
    var isBlank : Bool {
        return (self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }
    
    var removeWhiteSpace: String {
        return self.components(separatedBy: .whitespaces).joined()
    }
    
    var removeSpacesBothEnd: String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    var addingPercent:String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    var isNumeric : Bool {
        return NumberFormatter().number(from: self) != nil
    }
    
    func containsWhitespaceAndNewlines() -> Bool {
        return rangeOfCharacter(from: .whitespacesAndNewlines) != nil
    }
    
}

extension UIImageView {

    func setImageOnImageView(_ urlStr: String) {
        debugPrint("Image Url:- ",urlStr)
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: URL(string: urlStr), placeholderImage: UIImage(named: ""), options: .highPriority, completed: nil)
    }
}
