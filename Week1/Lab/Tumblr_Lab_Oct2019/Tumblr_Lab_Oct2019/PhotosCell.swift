//
//  PhotosCell.swift
//  Tumblr_Lab_Oct2019
//
//  Created by Sriram Narayanan on 10/14/19.
//  Copyright © 2019 Sriram Narayanan. All rights reserved.
//

import UIKit

class PhotosCell: UITableViewCell {
    //MARK: - Properties
    @IBOutlet var photoImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
