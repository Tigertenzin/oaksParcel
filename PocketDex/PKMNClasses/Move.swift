//
//  Move.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/13/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation


struct Move: Codable, Identifiable, Hashable {
    let id: Int
    let identifier: String
    let generation_id: Int
    let type_id: Int
    let power: Int? 
    let pp: Int?
    let accuracy: Int?
    let priority: Int?
    let target_id: Int?
    let damage_class_id: Int
    let effect_id: Int
    let effect_chance: Int?
//    let contest_type_id: Int
//    let contest_effect_id: Int
//    let super_contest_effect_id: Int
    
    var wrappedName: String {
        return identifier.replacingOccurrences(of: "-", with: " ").capitalized
    }
    
    var wrappedPower: String {
        if let power = power {
            return String(power)
        } else {
            return "--"
        }
    }
    
    var pkmnMovesName: String{
        return "pokemon_moves_byMove" + String(format:"%03d", id)
    }
    
    var sortPower: Int {
        if let power = power {
            return power
        } else {
            return 10000
        }
    }
    
    var wrappedPP: String {
        if let pp = pp {
            return String(pp)
        } else {
            return "--"
        }
    }
    
    var wrappedAccuracy: String {
        if let accuracy = accuracy {
            return String(accuracy)
        } else {
            return "--"
        }
    }
    
    var damage_class: String {
        if damage_class_id == 1 {
            return "Status"
        } else if damage_class_id == 2 {
            return "Physical"
        } else {
            return "Special"
        }
    }
    
    init() {
        id = 0
        identifier = "N/A"
        generation_id = 0
        type_id = 1
        power = 0
        pp = 0
        accuracy = 0
        priority = 0
        target_id = 10
        damage_class_id = 0
        effect_id = 0
        effect_chance = 0
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}


//id,identifier
//1,specific-move
//2,selected-pokemon-me-first
//3,ally
//4,users-field
//5,user-or-ally
//6,opponents-field
//7,user
//8,random-opponent
//9,all-other-pokemon
//10,selected-pokemon
//11,all-opponents
//12,entire-field
//13,user-and-allies
//14,all-pokemon
