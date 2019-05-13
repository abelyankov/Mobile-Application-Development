//
//  Location.swift
//  FindSpyGame
//
//  Created by Arthur Belyankov on 5/13/19.
//  Copyright © 2019 Arthur Belyankov. All rights reserved.
//

import Foundation
import SwiftyJSON

class Location{
    var id: Int
    var name: String
    
    init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        
    }
}
