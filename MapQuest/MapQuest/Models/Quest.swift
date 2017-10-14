//
//  Quest.swift
//  MapQuest
//
//  Created by Mushaheed Kapadia on 10/14/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import Foundation

enum State: String {
    case ERROR = "Error"
    case IN_PROGRESS = "In Progess"
    case COMPLETED = "Completed"
}

let IN_PROGRESS_STRING: String! = "In Progess"
let COMPELTED_STRING: String! = "Completed"

class Quest: NSObject {
    var name: String!
    var state: State
    
    init(questDict: NSDictionary) {
        name = questDict["name"] as! String
        state = Quest.getStateFromString(stateString: questDict["state"] as! String)
    }
    
    class func getStateFromString(stateString: String!) -> State {
        if stateString == IN_PROGRESS_STRING {
            return .IN_PROGRESS
        }
        
        if stateString == COMPELTED_STRING {
            return .COMPLETED
        }
        
        return .ERROR
    }
}
