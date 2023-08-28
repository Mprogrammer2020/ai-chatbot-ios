//
//  SenderTextTVC.swift
//  ChatSupport
//
//  Created by netset on 13/06/23.
//

import UIKit

class SenderTextTVC: UITableViewCell,Reusable {

    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var vwBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
