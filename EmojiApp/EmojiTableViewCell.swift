//
//  EmojiTableViewCell.swift
//  EmojiApp
//
//  Created by Danis on 09.02.2021.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func set(object:Emoji) {
        self.emojiLabel.text = object.emoji
        self.nameLabel.text = object.name
        self.infoLabel.text = object.info
    }

}
