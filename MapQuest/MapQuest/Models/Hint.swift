//
//  Hint.swift
//  MapQuest
//
//  Created by Justin Sumner on 10/19/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit
import Parse

enum HintType {
    case TEXT
    case PHOTO
    case GEOLOCATION
    case ERROR
}

class Hint: NSObject {
    
    static func hintStringToHintType(hintTypeString: String) -> HintType {
        if hintTypeString == "text" {
            return HintType.TEXT
        }
        return HintType.ERROR
    }
    
    static func hintTypetoHintString(hintType: HintType) -> String {
        if hintType == HintType.TEXT {
            return "text"
        }
        return "error"
    }
    
    let hintType: HintType!
    let image: PFFile?
    var text: String?
    let geo: PFGeoPoint?

    init(hintType: HintType) {
        self.hintType = hintType
        if hintType == HintType.TEXT {
            self.text = ""
        }
        self.image = nil
        self.geo = nil
    }
    
    init(hintType: String, imageFile: PFFile?, text: String?, geo: PFGeoPoint?) {
        self.hintType = Hint.hintStringToHintType(hintTypeString: hintType)
        self.image = imageFile
        self.text = text
        self.geo = geo
    }
    
    class func getPFFileFromImageData(imageData: Data?) -> PFFile? {

        if let imageData = imageData {
            return PFFile(name: "image.png", data: imageData)
        }
        return nil
    }
    
    class func formatImageData(imageFile: PFFile?, forParse: Bool?, hint: Hint) -> Any? {

        if forParse! {
            return imageFile

        }
        else {

            return "just a string"
        }
    }
    
    class func formatGeo(geo: PFGeoPoint?, forParse: Bool) -> Any? {
        if forParse {
            return geo
        }
        else {
            return "geostring"
        }
    
    }
    
    class func toList(hints: [Hint], forParse: Bool?) -> [NSDictionary] {
        return hints.map({ (hint) -> NSDictionary in
            print("hint list")
            print(hint.image)
            print(type(of: hint.image))
            return ["hintType": hint.hintType,
                    "text": hint.text,
                    "image": formatImageData(imageFile: hint.image, forParse: forParse, hint: hint),
                    "geo": formatGeo(geo: hint.geo, forParse: forParse!)
            ]
        })
    }
    
    class func fromList(hintDicts: [NSDictionary]) -> [Hint] {
        return hintDicts.map({ (hintDict) -> Hint in
            let hintType = hintDict["hintType"] as! String
            let hintText = hintDict["text"] as! String
            let hintImageFile = hintDict["image"] as? PFFile


            var hintGeo = hintDict["geo"] as? PFGeoPoint ?? nil
            return Hint(hintType: hintType, imageFile: hintImageFile, text: hintText, geo: hintGeo)
        })
    }
    
}
