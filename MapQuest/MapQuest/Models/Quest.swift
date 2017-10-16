//
//  Quest.swift
//  MapQuest
//
//  Created by Mushaheed Kapadia on 10/14/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import Foundation
import Parse

enum State: String {
    case ERROR = "Error"
    case IN_PROGRESS = "In Progess"
    case COMPLETED = "Completed"
}

let IN_PROGRESS_STRING: String! = "In Progess"
let COMPELTED_STRING: String! = "Completed"

class Quest: NSObject {
    static let className: String  = "Quest"
    
    var name: String!
    var state: State!
    var questDescription: String!
    var clues: [Clue]!
    
    init(questDict: PFObject) {
        name = questDict["name"] as! String
        state = Quest.getStateFromString(stateString: questDict["state"] as! String)
        questDescription = questDict["questDescription"] as! String
        clues = Clue.fromList(clueDicts: questDict["clues"] as? [NSDictionary] ?? [NSDictionary]())
    }
    
    init(questDict: NSDictionary) {
        name = questDict["name"] as! String
        state = Quest.getStateFromString(stateString: questDict["state"] as! String)
        questDescription = questDict["questDescription"] as! String
        clues = Clue.fromList(clueDicts: questDict["clues"] as? [NSDictionary] ?? [NSDictionary]())
    }
    
    init(name: String, description: String) {
        self.name = name
        questDescription = description
        state = State.IN_PROGRESS
        clues = [Clue]()
    }
    
    func addClue(clue: Clue) {
        clues.append(clue)
    }
    
    func save(success: @escaping () -> Void, error: @escaping (Error) -> Void) -> Void {
        let quest = PFObject(className: Quest.className)
        quest["name"] = self.name
        quest["state"] = Quest.getStringFromState(state: self.state)
        quest["questDescription"] = self.questDescription
        quest["clues"] = Clue.toList(clues: self.clues)
        quest.saveInBackground { (didSave, err) in
            if (didSave) {
                return success()
            }
            return error(err!)
        }
    }
    
    class func fetchAllQuests(completion: @escaping ([Quest]) -> Void) -> Void {
        return MapQuestClient.getInstance().fetchAllQuests(completion: completion)
    }
    
    class func fetchMyQuests(completion: @escaping ([Quest]) -> Void) -> Void {
        return MapQuestClient.getInstance().fetchMyQuests(completion: completion)
    }
    
    class func fetchInProgressQuests(completion: @escaping ([Quest]) -> Void) -> Void {
        return MapQuestClient.getInstance().fetchInProgressQuests(completion: completion)
    }
    
    class func fetchCompletedQuests(completion: @escaping ([Quest]) -> Void) -> Void {
        return MapQuestClient.getInstance().fetchCompletedQuests(completion: completion)
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
    
    class func getStringFromState(state: State) -> String {
        if state == .IN_PROGRESS {
            return IN_PROGRESS_STRING
        }
        
        if state == .COMPLETED {
            return COMPELTED_STRING
        }
        
        return ""
    }
    
    
}
