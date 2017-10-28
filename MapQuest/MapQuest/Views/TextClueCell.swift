//
//  TextClueCell.swift
//  MapQuest
//
//  Created by Mushaheed Kapadia on 10/25/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit

class TextClueCell: UITableViewCell {

    @IBOutlet weak var textHintView: UITextView!
    
    var hint: Hint!

    override func awakeFromNib() {
        super.awakeFromNib()
        textHintView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TextClueCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.hint.text = textView.text
    }
}
