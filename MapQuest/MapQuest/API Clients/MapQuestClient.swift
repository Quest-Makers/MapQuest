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
    
    func fetchAllQuests(completion: ([Quest]) -> Void) -> Void {
        return completion([Quest]())
    }
    
    func fetchMyQuests(completion: ([Quest]) -> Void) -> Void {
        return completion([Quest]())
    }
    
    func fetchInProgressQuests(completion: ([Quest]) -> Void) -> Void {
        return completion([Quest]())
    }
    
    func fetchCompletedQuests(completion: ([Quest]) -> Void) -> Void {
        return completion([Quest]())
    }
    
}
