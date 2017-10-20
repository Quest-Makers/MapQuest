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
    var hintImage: UIImage?
    var hintGeo: String?
    
    var wasAdded: Bool = false

    @IBAction func addNewClue(_ sender: Any) {
        wasAdded = true
        let hints = [
            Hint(hintType: "text", image: nil, text: hintTextView.text, geo: nil),
            Hint(hintType: "image", image: hintImage, text: answerTextField.text, geo: nil),
            Hint(hintType: "geo", image: nil, text: "asd", geo: "test"),
        ]
        let clue = Clue(hint: hintTextView.text!, answer: answerTextField.text!, hints: hints)
        print("set clue")
        print(clue.hints)
        delegate?.addClue?(clue: clue)
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newClueViewController = mainStoryboard.instantiateViewController(withIdentifier: "NewClueViewController") as! NewClueViewController
        newClueViewController.delegate = self.delegate
        self.navigationController?.pushViewController(newClueViewController, animated: true)
    }
    
    @IBAction func finalize(_ sender: Any) {
        if !wasAdded {
            let clue = Clue(hint: answerTextField.text!, answer: answerTextField.text!, hints: [])
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
    
    @IBAction func onPhotoLibraryPressed(_ sender: Any) {
        
        let photoVC = UIImagePickerController()
        photoVC.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        photoVC.allowsEditing = true
        photoVC.sourceType = .photoLibrary
        
        self.present(photoVC, animated: true) {
            //do something custom here
        }
        
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

extension NewClueViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        //self.imageView.image = originalImage
        print("got an image")
        self.hintImage = editedImage
        print("set image")
        self.dismiss(animated: true, completion: nil)
        print("dismissed")
    }
}
