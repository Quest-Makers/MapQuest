//
//  ShowMapViewController.swift
//  MapQuest
//
//  Created by Justin Sumner on 11/1/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit
import MapKit

class ShowMapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    var hint: Hint! {
        
        
        didSet {

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hintLocation = MKCoordinateRegionMake(hint.geoLocation!,
                                                  MKCoordinateSpanMake(0.1, 0.1))
        mapView.setRegion(hintLocation, animated: false)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = hint.geoLocation!
        mapView.addAnnotation(annotation)
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
