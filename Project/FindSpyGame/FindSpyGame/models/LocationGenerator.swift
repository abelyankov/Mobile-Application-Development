//
//  LocationGenerator.swift
//  FindSpyGame
//
//  Created by Arthur Belyankov on 5/8/19.
//  Copyright © 2019 Arthur Belyankov. All rights reserved.
//

import Foundation


class LocationGenerator{
    static func getLocations() -> [String]{
        var locations = [String]()
        locations.append("school")
        locations.append("hospital")
        locations.append("Garden")
        locations.append("Cinema")
        locations.append("Garbage")
        locations.append("Almaty central stadium")
        locations.append("University")
        locations.append("Police station")
        locations.append("Jail")
        return locations
    }
}
