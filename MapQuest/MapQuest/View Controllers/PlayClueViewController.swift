//
//  PlayClueViewController.swift
//  MapQuest
//
//  Created by Justin Sumner on 10/15/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit

class PlayClueViewController: UIViewController {
    
    var delegate: QuestDetailsViewController? = nil
    var clueProgress: Int = 0

    @IBOutlet weak var clueText: UILabel!
    @IBOutlet weak var answerInput: UITextField!
    
    @IBAction func solveClue(_ sender: Any) {
        print("input:")
        print(answerInput.text)
        print(self.delegate?.quest.clues.count)
        if clueProgress + 1 > (self.delegate?.quest.clues.count)! {
            print("This is already the end")
            return
        }
        if answerInput.text == self.delegate?.quest.clues[clueProgress].answer {
            print("correct")
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let playClueViewController = mainStoryboard.instantiateViewController(withIdentifier: "PlayClueViewController") as! PlayClueViewController
            playClueViewController.delegate = self.delegate
            playClueViewController.clueProgress = self.clueProgress + 1
            self.navigationController?.pushViewController(playClueViewController, animated: true)
        }
        else {
            let alert = UIAlertController(title: "Wrong", message: "Try again", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
//        wasAdded = true
//        let clue = Clue(hint: answerTextField.text!, answer: answerTextField.text!)
//        delegate?.addClue?(clue: clue)
//

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clueText.text = self.delegate?.quest.clues[clueProgress].hint
        print("correct answer:")
        print(self.delegate?.quest.clues[clueProgress].answer)
        // Do any additional setup after loading the view.
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
