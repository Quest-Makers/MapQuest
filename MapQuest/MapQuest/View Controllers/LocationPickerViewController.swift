//
//  LocationPickerViewController.swift
//  MapQuest
//
//  Created by Justin Sumner on 10/22/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit
import MapKit

protocol LocationPickerViewControllerDelegate {
    func addGeoLocationHint(sender: LocationPickerViewController, geoHintCoordinate: CLLocationCoordinate2D)
}


class LocationPickerViewController: UIViewController {

    @IBOutlet weak var mappy: MKMapView!
    
    var annotation: MKPointAnnotation? = nil
    var delegate: LocationPickerViewControllerDelegate? = nil

    @IBAction func addGeoLocationHint(_ sender: Any) {
        if let annotation = self.annotation as MKPointAnnotation! {
            self.delegate?.addGeoLocationHint(sender: self, geoHintCoordinate: annotation.coordinate)
        }
    }
    
    @objc func dropPin(tapGesture: UITapGestureRecognizer) {
        let tapLocation = tapGesture.location(in: mappy)
        let geoHintCoordinate = mappy.convert(tapLocation, toCoordinateFrom: mappy)
        
        if let annotation = self.annotation as MKPointAnnotation! {
            mappy.removeAnnotation(annotation)
            self.annotation = nil
        }

        self.annotation = MKPointAnnotation()
        self.annotation!.coordinate = geoHintCoordinate
        self.annotation!.title = "Geo Hint!"
        mappy.addAnnotation(self.annotation!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667),
                                              MKCoordinateSpanMake(0.1, 0.1))
        mappy.setRegion(sfRegion, animated: false)
        
        // add tap gesture recognizer to drop a pin
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LocationPickerViewController.dropPin))
        mappy.addGestureRecognizer(tapGestureRecognizer)
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
