//
//  ReceiverImageTVC.swift
//  ChatSupport
//
//  Created by netset on 16/06/23.
//

import UIKit

class ReceiverImageTVC: UITableViewCell,Reusable {

    @IBOutlet weak var imgVwMessage: UIImageView!
    @IBOutlet weak var imgVwTyping: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
