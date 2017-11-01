//
//  PlayClueCell.swift
//  MapQuest
//
//  Created by Justin Sumner on 10/29/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit

class PlayClueCell: UITableViewCell {

    @IBOutlet weak var clueLabel: UILabel!
    @IBOutlet weak var clueImage: UIImageView!
    
    var delegate: PlayClueViewController?
    var hint: Hint?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func showMapAction(_ sender: Any) {
        self.delegate!.performSegue(withIdentifier: "showMapSegue", sender: self)
    }

    
    
}
