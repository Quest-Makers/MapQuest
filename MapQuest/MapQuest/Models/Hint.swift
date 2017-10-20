//
//  Hint.swift
//  MapQuest
//
//  Created by Justin Sumner on 10/19/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit

class Hint: NSObject {
    let hintType: String!
    let image: UIImage?
    let text: String?
    let geo: String?
    
    init(hintType: String, image: UIImage?, text: String?, geo: String?) {
        self.hintType = hintType
        self.image = image
        self.text = text
        self.geo = geo
    }
    
}
