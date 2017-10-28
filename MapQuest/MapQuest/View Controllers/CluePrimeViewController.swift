//
//  CluePrimeViewController.swift
//  MapQuest
//
//  Created by Mushaheed Kapadia on 10/25/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit
import SDCAlertView

extension UITableView {
    func mapQuestRegisterNib(cellClass: AnyClass) {
        let className = String(describing: cellClass)
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellReuseIdentifier: className)
    }
    
    func mapQuestDequeueReusableCellClass(cellClass: AnyClass) -> UITableViewCell {
        let className = String(describing: cellClass)
        return dequeueReusableCell(withIdentifier: className)!
    }
}


class CluePrimeViewController: UIViewController {
    
    var delegate: NewClueViewControllerDelegate? = nil

    @IBOutlet weak var tableView: UITableView!
    
    var hints: [Hint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)

        let footerView = Bundle.main.loadNibNamed("ClueFooterView", owner: self, options: nil)?.first as! ClueFooterView
        footerView.delegate = self
        tableView.tableFooterView = footerView
        
        tableView.mapQuestRegisterNib(cellClass: TextClueCell.self)
        tableView.mapQuestRegisterNib(cellClass: PhotoHintTableViewCell.self)
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CluePrimeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hint = hints[indexPath.row]
        
        if hint.hintType == HintType.TEXT {
            let cell = tableView.mapQuestDequeueReusableCellClass(cellClass: TextClueCell.self) as! TextClueCell
            cell.hint = hint
            return cell
        }
        
        if hint.hintType == HintType.PHOTO {
            let cell = tableView.mapQuestDequeueReusableCellClass(cellClass: PhotoHintTableViewCell.self) as! PhotoHintTableViewCell
            cell.hint = hint
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hints.count
    }
}

extension CluePrimeViewController: ClueFooterViewDelegate {
    
    func addTextHint() {
        hints.append(Hint(hintType: HintType.TEXT))
        self.tableView.reloadData()
    }
    
    func addPhotoHint() {
        let alert = AlertController(title: "Photo Hint", message: "How would you like to add a photo?", preferredStyle: .actionSheet)
        
        let cancelAction = AlertAction(title: "Nevermind", style: .destructive)
        
        let takePhotoAction = AlertAction(title: "Take Photo", style: .normal) { (action) in
             let vc = UIImagePickerController()
             vc.delegate = self
             vc.allowsEditing = false
             vc.sourceType = .camera
             self.present(vc, animated: true, completion: nil)
        }
        
        let chooseFromLibrary = AlertAction(title: "Choose From Library", style: .normal) { (action) in
            let vc = UIImagePickerController()
            vc.delegate = self
            vc.allowsEditing = false
            vc.sourceType = .photoLibrary
            self.present(vc, animated: true, completion: nil)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(takePhotoAction)
        alert.addAction(chooseFromLibrary)
        alert.present()
    }
    
    func addClue(answerText: String) {
        let validHints = hints.reduce(true) { (isValid, hint) -> Bool in
            return isValid && hint.isValid()
        }
        
        if !validHints {
            let alert = UIAlertController(title: "Invalid Hints",
                                          message: "There was an error processing one of your hints, please try again.",
                                          preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let clue = Clue(answer: answerText, hints: hints)
        delegate?.addClue?(clue: clue)
        
        // next clue
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let cluePrimeViewController = mainStoryboard.instantiateViewController(withIdentifier: "CluePrimeViewController") as! CluePrimeViewController
        cluePrimeViewController.delegate = self.delegate
        self.navigationController?.pushViewController(cluePrimeViewController, animated: true)
    }
    
    func finalClue() {
        self.delegate?.finished()
    }
    
    func invalidAnswer() {
        let alert = UIAlertController(title: "Invalid Answer",
                                      message: "You must have an answer for your clue.",
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension CluePrimeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let hint = Hint(hintType: HintType.PHOTO)
        hint.photo = info[UIImagePickerControllerOriginalImage] as! UIImage?
        self.hints.append(hint)
        self.tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}
