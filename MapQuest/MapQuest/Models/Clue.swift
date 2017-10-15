//
//  Clue.swift
//  MapQuest
//
//  Created by Mushaheed Kapadia on 10/14/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import UIKit

class Clue: NSObject {
    
    var hint: String!
    var answer: String!
    
    init(hint: String, answer: String) {
        self.hint = hint
        self.answer = answer
    }
    
    class func fromList(clueDicts: [NSDictionary]) -> [Clue] {
        return [Clue]()
    }

}
