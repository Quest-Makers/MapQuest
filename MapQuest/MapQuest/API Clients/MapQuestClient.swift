//
//  MapQuestAPIClient.swift
//  MapQuest
//
//  Created by Mushaheed Kapadia on 10/14/17.
//  Copyright © 2017 Mushaheed Kapadia. All rights reserved.
//

import Foundation
import Parse

class MapQuestClient: NSObject {
    
    private static var client: MapQuestClient! = nil
    
    override init() {
        // Initialize Parse
        // Set applicationId and server based on the values in the Heroku settings.
        // clientKey is not used on Parse open source unless explicitly configured
        Parse.initialize(
            with: ParseClientConfiguration(block: { (configuration: ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "myAppId"
                configuration.clientKey = nil  // set to nil assuming you have not set clientKey
                configuration.server = "https://questmakers.herokuapp.com/parse"
            })
        )
    }
    
    class func initializeClient() {
        // noop if client is already initialized
        if client == nil {
            client = MapQuestClient()
        }
    }
    
    class func getInstance() -> MapQuestClient {
        if client == nil {
            client = MapQuestClient()
        }
        return client
    }
    
    func fetchAllQuests(completion: @escaping ([Quest]) -> Void) -> Void {
        let questQuery =  PFQuery(className: Quest.className)
        questQuery.findObjectsInBackground { (questDicts: [PFObject]!, error) in
            if error != nil {
                return completion([Quest]())
            }
            
            let quests = questDicts.map({ (questDict) -> Quest in
                return Quest(questDict: questDict)
            })
            
            return completion(quests)
            
        }
    }
    
    func fetchMyQuests(completion: ([Quest]) -> Void) -> Void {
        let userDefaults = UserDefaults.standard
        let localQuestNames = userDefaults.object(forKey: "quests") as? [String] ?? [String]()
        
        let quests = localQuestNames.map { (questName: String) -> Quest in
            return Quest(questDict: userDefaults.object(forKey: questName) as! NSDictionary)
        }

        return completion(quests)
    }
    
    func fetchInProgressQuests(completion: ([Quest]) -> Void) -> Void {
        fetchMyQuests { (quests: [Quest]) in
            let inProgressQuests = quests.filter({ (quest: Quest) -> Bool in
                quest.state == State.IN_PROGRESS
            })
            return completion(inProgressQuests)
        }
    }
    
    func fetchCompletedQuests(completion: ([Quest]) -> Void) -> Void {
        fetchMyQuests { (quests: [Quest]) in
            let completedQuests = quests.filter({ (quest: Quest) -> Bool in
                quest.state == State.COMPLETED
            })
            return completion(completedQuests)
        }
    }
    
}
