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
        return clueDicts.map({ (clueDict) -> Clue in
            return Clue(hint: clueDict["hint"] as! String, answer: clueDict["answer"] as! String)
        })
    }

    class func toList(clues: [Clue]) -> [NSDictionary] {
        return clues.map({ (clue) -> NSDictionary in
            return ["hint": clue.hint, "answer": clue.answer]
        })
    }
}
