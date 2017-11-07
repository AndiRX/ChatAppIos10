//
//  MessageCell.swift
//  ChatAppIos10
//
//  Created by Petr on 07.11.17.
//  Copyright © 2017 Andi. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(user: String, message: String) {
        userLabel.text = user
        messageLabel.text = message
    }
    
}
