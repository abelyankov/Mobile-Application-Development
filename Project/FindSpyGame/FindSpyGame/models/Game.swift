//
//  Game.swift
//  FindSpyGame
//
//  Created by Aitakhunov Rustam on 5/8/19.
//  Copyright © 2019 Rustam Aitakhunov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//struct Game {
//    var location: String
//    var spyNumber: Int
//    var totalNumberOfPlayers: Int
//
//    init(_ location: String, _ spyNumber: Int, _ totalNumberOfPlayers: Int) {
//        self.location = location
//        self.spyNumber = spyNumber
//        self.totalNumberOfPlayers = totalNumberOfPlayers
//    }
//}

class Game {
    var game_id: Int!
    var user_id: Int!
    var phoneNumber: String!
    var fCMToken: String!
    var location: String!
    var totalNumberOfPlayers: Int!
    var spyNumber: Int!
    var currentPlayerNumber: Int!
    var readyPlayerNumber: Int!
    var finishedPlayerNumber: Int!
    var type: Int!
    
    
    init(game_id: Int, user_id: Int, phoneNumber: String, fCMToken: String, location: String, totalNumberOfPlayers: Int, spyNumber: Int, currentPlayerNumber: Int, readyPlayerNumber: Int, finishedPlayerNumber: Int) {
        self.game_id = game_id
        self.user_id = user_id
        self.phoneNumber = phoneNumber
        self.fCMToken = phoneNumber
        self.location = location
        self.totalNumberOfPlayers = totalNumberOfPlayers
        self.spyNumber = spyNumber
        self.currentPlayerNumber = currentPlayerNumber
        self.readyPlayerNumber = readyPlayerNumber
        self.finishedPlayerNumber = finishedPlayerNumber
    }
    static func Games(completionHandler: @escaping ([Game]) -> ()) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let URL = "http://192.168.43.48:8080/game_list/"
        
        var games = [Game]()
        
        Alamofire.request(URL, method: .get).validate().responseJSON { (response) in
            if let value = response.result.value {
                let json = JSON(value)
                for result in json.arrayValue {
                    let game_id  = result["id"].intValue
                    let user_id = result["players"]["id"].intValue
                    let phoneNumber = result["players"]["phoneNumber"].stringValue
                    let fCMToken = result["players"]["fCMToken"].stringValue
                    let location = result["location"].stringValue
                    let totalNumberOfPlayers = result["totalNumberOfPlayers"].intValue
                    let spyNumber = result["spyNumber"].intValue
                    let currentPlayerNumber = result["currentPlayerNumber"].intValue
                    let readyPlayerNumber = result["readyPlayerNumber"].intValue
                    let finishedPlayerNumber = result["finishedPlayerNumber"].intValue
//                    print(json)
                    let game = Game(game_id: game_id, user_id: user_id, phoneNumber: phoneNumber, fCMToken: fCMToken, location: location, totalNumberOfPlayers: totalNumberOfPlayers, spyNumber: spyNumber,currentPlayerNumber: currentPlayerNumber, readyPlayerNumber: readyPlayerNumber, finishedPlayerNumber: finishedPlayerNumber)
                    games.append(game)
                }
                completionHandler(games)
            }
        }
    }
}
