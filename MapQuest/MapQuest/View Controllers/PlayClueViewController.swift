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

    @IBOutlet weak var clueText: UILabel!
    @IBOutlet weak var answerInput: UITextField!
    
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
