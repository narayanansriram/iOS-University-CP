//
//  CommentCell.swift
//  Parstagram
//
//  Created by Sriram Narayanan on 11/21/19.
//  Copyright © 2019 Sriram Narayanan. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
