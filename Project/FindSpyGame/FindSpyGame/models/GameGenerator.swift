//
//  GameGenerator.swift
//  FindSpyGame
//
//  Created by Arthur Belyankov on 5/8/19.
//  Copyright © 2019 Arthur Belyankov. All rights reserved.
//

import Foundation

class GameGenerator{
    static func generateGame(_ numberOfPlayers: Int) -> Game{
        let locations = LocationGenerator.getLocations()
        let location = locations[Int.random(in: 0..<locations.count)]
        let spyNumber = Int.random(in: 1..<numberOfPlayers)
        return Game(location, spyNumber)
    }
}

