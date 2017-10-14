//
//  QuestTableViewCell.swift
//  MapQuest
//
//  Created by Mushaheed Kapadia on 10/14/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit

class QuestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var questNameLabel: UILabel!

    var quest: Quest! {
        didSet {
            questNameLabel.text = quest.name
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
