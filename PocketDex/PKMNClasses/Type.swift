//
//  File.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/14/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation

struct Type: Codable, Identifiable, Hashable {
    
    let id: Int
    let identifier: String
//    let generation_id: Int
//    let damage_class_id: Int
    
    var wrappedName: String {
        return identifier.capitalizingFirstLetter()
    }
}

//"id": 1,
//"identifier": "normal",
//"generation_id": 1,
//"damage_class_id": 2
