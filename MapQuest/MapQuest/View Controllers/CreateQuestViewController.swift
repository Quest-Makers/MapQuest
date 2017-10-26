//
//  CreateQuestViewController.swift
//  MapQuest
//
//  Created by Mushaheed Kapadia on 10/14/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit
import SDCAlertView

class CreateQuestViewController: UIViewController {

    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var bgImage: UIImageView!
    
    var quest: Quest!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        getStartedButton.layer.cornerRadius = 10
        getStartedButton.clipsToBounds = true
        updateStartButton()
    }
    
    @IBAction func descChanged(_ sender: Any) {
        updateStartButton()
    }
    @IBAction func titleChanged(_ sender: Any) {
        updateStartButton()
    }
    
    func updateStartButton() {
        if titleTextField.text != "" && descriptionTextField.text != "" {
            getStartedButton.backgroundColor = UIColor(red: 0.4, green: 1.0, blue: 0.2, alpha: 0.5)
            getStartedButton.setTitleColor(UIColor.white, for: [])
        }
        else {
            getStartedButton.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
            getStartedButton.setTitleColor(UIColor.gray, for: [])
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident == "newClueSegue" {
                print("asd segue")
                if titleTextField.text == "" {
                    let alert = UIAlertController(title: "No", message: "Title Can't be blank", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                else if descriptionTextField.text == "" {
                    let alert = UIAlertController(title: "No", message: "Description can't be blank", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                else {
                    return true
                }
            }
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        quest = Quest(name: titleTextField.text!, description: descriptionTextField.text!)
        if let destination = segue.destination as? NewClueViewController {
            destination.delegate = self
        }
    }

}

extension CreateQuestViewController: NewClueViewControllerDelegate {
    func addClue(clue: Clue) {
        quest.addClue(clue: clue)
    }
    
    func finished() {
        print("Clues in Quest: ", quest.clues.count)
        navigationController?.popToRootViewController(animated: true)
        
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        
        let alert = AlertController(title: "Saving quest", message: "Trying to upload your awesome quest...")
        alert.contentView.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: alert.contentView.centerXAnchor).isActive = true
        spinner.topAnchor.constraint(equalTo: alert.contentView.topAnchor).isActive = true
        spinner.bottomAnchor.constraint(equalTo: alert.contentView.bottomAnchor).isActive = true
        
        alert.present()
        
        // save quest to network
        quest.save(success: {
            self.titleTextField.text = ""
            self.descriptionTextField.text = ""
            AlertController.alert(withTitle: "Quest Created!", message: "Your quest is awesome!", actionTitle: "Thanks!")
            print("Quest saved to network!")
        }) { (error: Error) in
            print(error)
        }
    }
    
}


