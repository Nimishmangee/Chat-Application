//
//  MessageKaCell.swift
//  Flash Chat iOS13
//
//  Created by Nimish Mangee on 03/07/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

class MessageKaCell: UITableViewCell {
    
    
    @IBOutlet weak var leftImageView: UIImageView!
    
    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBOutlet weak var messageBubble: UIView!
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageBubble.layer.cornerRadius=messageBubble.frame.size.height/8;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
