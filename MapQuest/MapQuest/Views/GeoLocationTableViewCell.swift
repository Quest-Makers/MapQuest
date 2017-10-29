//
//  GeoLocationTableViewCell.swift
//  MapQuest
//
//  Created by Mushaheed Kapadia on 10/28/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit
import MapKit

class GeoLocationTableViewCell: UITableViewCell {

    var hint: Hint! {
        didSet {
            let hintLocation = MKCoordinateRegionMake(hint.geoLocation!,
                                                      MKCoordinateSpanMake(0.1, 0.1))
            mappy.setRegion(hintLocation, animated: false)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = hint.geoLocation!
            mappy.addAnnotation(annotation)
        }
    }
    
    @IBOutlet weak var mappy: MKMapView!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
