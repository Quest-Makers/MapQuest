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
    
    @IBAction func addNewClue(_ sender: Any) {
        let clue = Clue()
        delegate?.addClue?(clue: clue)
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newClueViewController = mainStoryboard.instantiateViewController(withIdentifier: "NewClueViewController") as! NewClueViewController
        newClueViewController.delegate = self.delegate
        self.navigationController?.pushViewController(newClueViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
