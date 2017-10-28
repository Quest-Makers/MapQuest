//
//  ClueFooterView.swift
//  MapQuest
//
//  Created by Mushaheed Kapadia on 10/25/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit

protocol ClueFooterViewDelegate {
    func addHint(hintType: HintType)
    func addClue(answerText: String)
    func finalClue()
}

class ClueFooterView: UIView {
    
    var delegate: ClueFooterViewDelegate? = nil

    @IBOutlet weak var answerTextField: UITextField!
    
    @IBAction func finalize(_ sender: Any) {
        if let text = answerTextField.text as String! {
            if text != "" {
                self.delegate?.addClue(answerText: text)
                self.delegate?.finalClue()
            }
        }
    }
    
    @IBAction func addClue(_ sender: Any) {
        if let text = answerTextField.text as String! {
            if text != "" {
                self.delegate?.addClue(answerText: text)
                return
            }
        }
        // error out, can't have empty answer text
    }
    
    @IBAction func addGeoHint(_ sender: Any) {
    }
    
    @IBAction func addPhotoHint(_ sender: Any) {
    }
    
    @IBAction func addTextHint(_ sender: Any) {
        self.delegate?.addHint(hintType: HintType.TEXT)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
