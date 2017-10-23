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
    
    init(hintType: String, imageFile: PFFile?, text: String?, geo: String?) {
//        var imageData: Data?
//        var imageFile: PFFile?
//        if let image = image {
//            imageData = UIImagePNGRepresentation(image)
//            imageFile = Hint.getPFFileFromImageData(imageData: imageData)
//        }
        self.hintType = hintType
        self.image = imageFile
        self.text = text
        self.geo = geo
        super.init()
    }
    
    class func getPFFileFromImageData(imageData: Data?) -> PFFile? {
        // check if image is not nil
            // get image data and check if that is not nil
        if let imageData = imageData {
            return PFFile(name: "image.png", data: imageData)
        }
        return nil
    }
    
    class func formatImageData(imageFile: PFFile?, forParse: Bool?, hint: Hint) -> Any? {
        // check if image is not nil
        // get image data and check if that is not nil
        if forParse! {
            return imageFile
//            if let imageData = imageData {
//                return PFFile(name: "image.png", data: imageData)
//            }
//            return nil
        }
        else {
            //let encodedData = NSKeyedArchiver.archivedData(withRootObject: imageData)
            //return encodedData
            return "just a string"
        }
    }
    
    class func toList(hints: [Hint], forParse: Bool?) -> [NSDictionary] {
        return hints.map({ (hint) -> NSDictionary in
            print("hint list")
            print(hint.image)
            print(type(of: hint.image))
            return ["hintType": hint.hintType,
                    "text": hint.text,
                    "image": formatImageData(imageFile: hint.image, forParse: forParse, hint: hint)
            ]
        })
    }
    
    class func fromList(hintDicts: [NSDictionary]) -> [Hint] {
        return hintDicts.map({ (hintDict) -> Hint in
//            let hints = hintDict["hints"] as? [Hint] ?? []
//            print("asd")
//            print("hints")
            let hintType = hintDict["hintType"] as! String
            let hintText = hintDict["text"] as! String
            let hintImageFile = hintDict["image"] as? PFFile


            var hintGeo = hintDict["geo"] as? String ?? ""
            return Hint(hintType: hintType, imageFile: hintImageFile, text: hintText, geo: hintGeo)
        })
    }
    
}
