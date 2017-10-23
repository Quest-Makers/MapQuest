//
//  LocationPickerViewController.swift
//  MapQuest
//
//  Created by Justin Sumner on 10/22/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit
import MapKit

class LocationPickerViewController: UIViewController {
    
    var locationChosen: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("location picker")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setLocationTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
