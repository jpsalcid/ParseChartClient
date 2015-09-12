//
//  MessageTableViewCell.swift
//  ChatClient
//
//  Created by Jasen Salcido on 9/11/15.
//  Copyright (c) 2015 Jasen Salcido. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
