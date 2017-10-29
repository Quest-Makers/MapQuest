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
        else if hintTypeString == "photo" {
            return HintType.PHOTO
        }
        return HintType.ERROR
    }
    
    static func hintTypetoHintString(hintType: HintType) -> String {
        if hintType == HintType.TEXT {
            return "text"
        }
        else if hintType == HintType.PHOTO {
            return "photo"
        }
        return "error"
    }
    

    let image: PFFile?
    let geo: PFGeoPoint?

    let hintType: HintType!
    var text: String?
    var photo: UIImage?
    var geoLocation: CLLocationCoordinate2D?
    
    init(hintType: HintType) {
        self.hintType = hintType
        self.text = ""
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
        self.geoLocation = nil
    }
    
    func isValid() -> Bool {
        if self.hintType == HintType.TEXT {
            if let text = self.text as String! {
                if text != "" {
                    return true
                }
            }
        }

        if self.hintType == HintType.PHOTO {
            if self.photo != nil {
                return true
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
    
    class func toList(hints: [Hint], forParse: Bool) -> [NSDictionary] {
        return hints.map({ (hint) -> NSDictionary in
            if !forParse {
                return ["hintType": hintTypetoHintString(hintType: hint.hintType),
                        "text": hint.text! as Any]
            }
            if hint.hintType == HintType.TEXT {
                return ["hintType": hintTypetoHintString(hintType: hint.hintType),
                        "text": hint.text! as Any]
            }
            else if hint.hintType == HintType.PHOTO {
                return ["hintType": hintTypetoHintString(hintType: hint.hintType),
                        "photo": PFFile(data: UIImageJPEGRepresentation(hint.photo!, 1.0)!) as Any]
            }
            else if hint.hintType == HintType.GEOLOCATION {
                return ["hintType": hintTypetoHintString(hintType: hint.hintType),
                        "geoLocation": ["latitude": hint.geoLocation!.latitude,
                                        "longitude": hint.geoLocation!.longitude] as Any]
            }
            
            return ["hintType": hintTypetoHintString(hintType: hint.hintType),
                    "text": hint.text! as Any]
        })
    }
    
    class func fromList(hintDicts: [NSDictionary]) -> [Hint] {
        return hintDicts.map({ (hintDict) -> Hint in
            let hintTypeString = hintDict["hintType"] as! String
            
            let hintType = hintStringToHintType(hintTypeString: hintTypeString)
            
            if hintType == HintType.TEXT {
                let text = hintDict["text"] as? String ?? ""
                let hint = Hint(hintType: hintType)
                hint.text = text
                return hint
            }
            
            if hintType == HintType.PHOTO {
                let photoPFFile = hintDict["photo"] as? PFFile ?? nil
                if photoPFFile == nil {
                    return Hint(hintType: HintType.ERROR)
                }
                let hint =  Hint(hintType: hintType)
                photoPFFile!.getDataInBackground(block: { (photoData, error) in
                    if error == nil {
                        let photo = UIImage(data: photoData!)
                        hint.photo = photo
                    }
                })
                return hint
            }
            
            return Hint(hintType: HintType.ERROR)
            
            //let hintText = hintDict["text"] as! String
            //return Hint(hintType: hintType, imageFile: nil, text: hintText, geo: nil)
        })
    }
    
}
