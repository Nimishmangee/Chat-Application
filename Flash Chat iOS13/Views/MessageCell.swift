//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Nimish Mangee on 17/06/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
//    @IBOutlet weak var rightImageView: UIImageView!
//    @IBOutlet weak var leftImageView: UIImageView!
    
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var leftLabel: UILabel!
    
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var rightLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageBubble.layer.cornerRadius=messageBubble.frame.size.height/8;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
