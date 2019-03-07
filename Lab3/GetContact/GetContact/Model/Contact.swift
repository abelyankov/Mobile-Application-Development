//
//  Contact.swift
//  GetContact
//
//  Created by Narikbi on 2/21/19.
//  Copyright © 2019 KBTU. All rights reserved.
//

import UIKit

enum TagColor: String {
    case red
    case green
    case blue
    case yellow
    case orange
    
    static var all: [TagColor] {
        return [.red, .green, .blue, .yellow, .orange,
                .red, .green, .blue, .yellow, .orange,
                .red, .green, .blue, .yellow, .orange,
                .red, .green, .blue, .yellow, .orange,
                .red, .green, .blue, .yellow, .orange,
                .red, .green, .blue, .yellow, .orange]
    }
    
    var color: UIColor {
        switch self {
        case .red: return UIColor.red
        case .green: return UIColor.green
        case .blue: return UIColor.blue
        case .yellow: return UIColor.yellow
        case .orange: return UIColor.orange
        }
    }
}

class Contact: Codable {
    
    var firstname: String
    var lastname: String
    var phone: String
    var tagString: String
    
    var tag: TagColor {
        return TagColor(rawValue: tagString) ?? .red
    }
    
    init(firstname: String, lastname: String, phone: String, tag: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.phone = phone
        self.tagString = tag
    }
    
}
