//
//  MenuItemTableViewCell.swift
//  MapQuest
//
//  Created by Mushaheed Kapadia on 10/13/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {

    @IBOutlet weak var menuItemLabel: UILabel!
    
    var menuItem: String! {
        didSet {
            menuItemLabel.text = menuItem
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
