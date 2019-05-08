//
//  Game.swift
//  FindSpyGame
//
//  Created by Aitakhunov Rustam on 5/8/19.
//  Copyright © 2019 Rustam Aitakhunov. All rights reserved.
//

import Foundation

struct Game {
    var location: String
    var spyNumber: Int
    
    init(_ location: String, _ spyNumber: Int) {
        self.location = location
        self.spyNumber = spyNumber
    }
}
