//
//  NewClueViewController.swift
//  MapQuest
//
//  Created by Mushaheed Kapadia on 10/14/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit

@objc protocol NewClueViewControllerDelegate {
    @objc optional func addClue(clue: Clue)
    func finished()
}

class NewClueViewController: UIViewController {

    var delegate: NewClueViewControllerDelegate? = nil
    
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var hintTextView: UITextView!
    
    var wasAdded: Bool = false

    @IBAction func addNewClue(_ sender: Any) {
        wasAdded = true
        let clue = Clue(hint: answerTextField.text!, answer: answerTextField.text!)
        delegate?.addClue?(clue: clue)
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newClueViewController = mainStoryboard.instantiateViewController(withIdentifier: "NewClueViewController") as! NewClueViewController
        newClueViewController.delegate = self.delegate
        self.navigationController?.pushViewController(newClueViewController, animated: true)
    }
    
    @IBAction func finalize(_ sender: Any) {
        if !wasAdded {
            let clue = Clue(hint: answerTextField.text!, answer: answerTextField.text!)
            delegate?.addClue?(clue: clue)
        }
        delegate?.finished()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
