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
    var hints = [Hint]()
    
    init(hint: String, answer: String, hints: [Hint]) {
        self.hint = hint
        self.answer = answer
        self.hints = hints
    }
    
    class func fromList(clueDicts: [NSDictionary]) -> [Clue] {
        return clueDicts.map({ (clueDict) -> Clue in
            print(clueDict["hints"] ?? "no hints")
            var hints: [Hint]
            if let hintsDict = clueDict["hints"] as? [NSDictionary] {
                hints = Hint.fromList(hintDicts: hintsDict)
            }
            else {
                hints = []
            }
            return Clue(hint: clueDict["hint"] as! String, answer: clueDict["answer"] as! String, hints: hints)
        })
    }

    class func toList(clues: [Clue], forParse: Bool?) -> [NSDictionary] {
        return clues.map({ (clue) -> NSDictionary in
            return ["hint": clue.hint,
                    "answer": clue.answer,
                    "hints": Hint.toList(hints: clue.hints, forParse: forParse)
            ]
        })
    }
}
