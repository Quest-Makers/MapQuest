//
//  ViewController.swift
//  MapQuest
//
//  Created by Mushaheed Kapadia on 10/11/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    var shield = PFObject(className: "Armor")
    var huntName: String = ""
    var huntDescription: String = ""
    var screenStages: [ScreenStage] = []
    var treasureHunt: TreasureHunt = TreasureHunt()


    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded")
        
        shield["displayName"] = "Wooden Shield"
        shield["fireProof"] = false
        shield["rupees"] = 50
        shield.saveInBackground(block: { (success, error) in
            if (success) {
                print("Object was saved successfully")
            } else {
                print("Object was not saved successfully")
            }
        })
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? NewClueStageViewController {
            destination.treasureHunt = self.treasureHunt
        }
    }


}

