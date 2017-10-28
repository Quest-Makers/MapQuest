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
    var photo: UIImage?
    var text: String?
    let geo: PFGeoPoint?

    init(hintType: HintType) {
        self.hintType = hintType
        if hintType == HintType.TEXT {
            self.text = ""
        }
        self.photo = nil
        self.image = nil
        self.geo = nil
    }
    
    init(hintType: String, imageFile: PFFile?, text: String?, geo: PFGeoPoint?) {
        self.hintType = Hint.hintStringToHintType(hintTypeString: hintType)
        self.image = imageFile
        self.text = text
        self.geo = geo
        self.photo = nil
    }
    
    func isValid() -> Bool {
        if self.hintType == HintType.TEXT {
            if let text = self.text as String! {
                if text != "" {
                    return true
                }
            }
        }
        return false
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
            return ["hintType": hintTypetoHintString(hintType: hint.hintType),
                    "text": hint.text]
        })
    }
    
    class func fromList(hintDicts: [NSDictionary]) -> [Hint] {
        return hintDicts.map({ (hintDict) -> Hint in
            let hintType = hintDict["hintType"] as! String
            let hintText = hintDict["text"] as! String
            return Hint(hintType: hintType, imageFile: nil, text: hintText, geo: nil)
        })
    }
    
}
