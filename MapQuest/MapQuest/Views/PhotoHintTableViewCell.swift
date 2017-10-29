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
    @IBOutlet weak var photoHeight: NSLayoutConstraint!
    @IBOutlet weak var photoWidth: NSLayoutConstraint!
    
    var hint: Hint! {
        didSet {
            photoHintImageView.image = hint.photo
            let newWidth = self.frame.size.width
            photoWidth.constant = newWidth

            let originalHeight = (hint.photo?.size.height)!
            let originalWidth = (hint.photo?.size.width)!
            let ratio  = originalHeight/originalWidth
            photoHeight.constant = photoWidth.constant*ratio
            //            photoCellHeight.constant = width*ratio
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
