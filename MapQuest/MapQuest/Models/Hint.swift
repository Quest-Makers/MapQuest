//
//  Hint.swift
//  MapQuest
//
//  Created by Justin Sumner on 10/19/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit
import Parse

class Hint: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "Hint"
    }
    
    let hintType: String!
    let image: PFFile?
    let text: String?
    let geo: String?
    
    init(hintType: String, image: UIImage?, text: String?, geo: String?) {
        self.hintType = hintType
        self.image = Hint.getPFFileFromImage(image: image)
        self.text = text
        self.geo = geo
        super.init()
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
}
