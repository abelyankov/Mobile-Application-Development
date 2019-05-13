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
        locations.append("Школа")
        locations.append("Госпиталь")
        locations.append("Сад")
        locations.append("Кинотеатр")
        locations.append("Тюрьма")
        locations.append("Стадион")
        locations.append("Университет")
        locations.append("Полицейский участок")
        locations.append("Тюрма")
        return locations
    }
}
