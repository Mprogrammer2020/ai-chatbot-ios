//
//  ReceiverTextTVC.swift
//  ChatSupport
//
//  Created by netset on 13/06/23.
//

import UIKit

class ReceiverTextTVC: UITableViewCell,Reusable {

    @IBOutlet weak var vwBackground: UIView!
    @IBOutlet weak var imgVwTyping: UIImageView!
    @IBOutlet weak var txtVwMessage: UITextView!
    
    @IBOutlet weak var cnstHeightTxtVwMessage: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
