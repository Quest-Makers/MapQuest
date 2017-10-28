//
//  PhotoHintTableViewCell.swift
//  MapQuest
//
//  Created by Mushaheed Kapadia on 10/28/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit

class PhotoHintTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoHintImageView: UIImageView!

    var hint: Hint! {
        didSet {
            photoHintImageView.image = hint.photo
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
