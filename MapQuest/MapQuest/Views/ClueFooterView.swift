//
//  ClueFooterView.swift
//  MapQuest
//
//  Created by Mushaheed Kapadia on 10/25/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit

protocol ClueFooterViewDelegate {
    func addTextHint()
    func addPhotoHint()
    func addGeoHint()
    func addClue(answerText: String)
    func invalidAnswer()
    func finalClue()
}

class ClueFooterView: UIView {
    
    var delegate: ClueFooterViewDelegate? = nil

    @IBOutlet weak var answerTextField: UITextField!
    
    @IBAction func finalize(_ sender: Any) {
        if let text = answerTextField.text as String! {
//            if text != "" {
                self.delegate?.addClue(answerText: text)
                self.delegate?.finalClue()
//            }
        }
    }
    
    @IBAction func addClue(_ sender: Any) {
        if let text = answerTextField.text as String! {
            if text != "" {
                self.delegate?.addClue(answerText: text)
                return
            }
        }
        delegate?.invalidAnswer()
    }
    
    @IBAction func addGeoHint(_ sender: Any) {
        self.delegate?.addGeoHint()
    }
    
    @IBAction func addPhotoHint(_ sender: Any) {
        self.delegate?.addPhotoHint()
    }
    
    @IBAction func addTextHint(_ sender: Any) {
        self.delegate?.addTextHint()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
