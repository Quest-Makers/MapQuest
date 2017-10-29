//
//  PlayClueViewController.swift
//  MapQuest
//
//  Created by Justin Sumner on 10/15/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PlayClueViewController: UIViewController {
    
    var delegate: QuestDetailsViewController? = nil
    var clueProgress: Int = 0
    var hints: [Hint]? = []

    @IBOutlet weak var clueText: UILabel!
    @IBOutlet weak var answerInput: UITextField!
    @IBOutlet weak var photoView: PFImageView!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    @IBOutlet weak var solveButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.mapQuestRegisterNib(cellClass: TextClueCell.self)
        tableView.mapQuestRegisterNib(cellClass: PhotoHintTableViewCell.self)
        tableView.mapQuestRegisterNib(cellClass: GeoLocationTableViewCell.self)
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableViewAutomaticDimension
        
        setupViewResizerOnKeyboardShown()
        tableView.reloadData()
        
        
        //clueText.text = self.delegate?.quest.clues[clueProgress].hint
        hints = self.delegate?.quest.clues[self.clueProgress].hints
        var clues = self.delegate?.quest.clues
        print("correct answer:")
        print(self.delegate?.quest.clues[clueProgress].answer)
        if clueProgress + 1 >= (self.delegate?.quest.clues.count)! {
            solveButton.isHidden = true
            answerInput.isHidden = true
        }
        if clueProgress <= clues!.count {
            
//            self.photoView.file = self.delegate?.quest.clues[self.clueProgress].hints[1].image as? PFFile
//            self.photoView.loadInBackground()
//            if let geo = hints![2].geo {
//                lonLabel.text = "\(geo.longitude)"
//                latLabel.text = "\(geo.latitude)"
//            }
        }
        
        
        // Do any additional setup after loading the view.
        print("done")
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

extension PlayClueViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hint = hints?[indexPath.row]
        
        if hint?.hintType == HintType.TEXT {
            let cell = tableView.mapQuestDequeueReusableCellClass(cellClass: TextClueCell.self) as! TextClueCell
            cell.hint = hint
            return cell
        }
        
        if hint?.hintType == HintType.PHOTO {
            let cell = tableView.mapQuestDequeueReusableCellClass(cellClass: PhotoHintTableViewCell.self) as! PhotoHintTableViewCell
            cell.hint = hint
            return cell
        }
        
        if hint?.hintType == HintType.GEOLOCATION {
            let cell = tableView.mapQuestDequeueReusableCellClass(cellClass: GeoLocationTableViewCell.self) as! GeoLocationTableViewCell
            cell.hint = hint
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (hints?.count)!
    }
}
