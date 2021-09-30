//
//  File.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/14/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation

struct MoveEffectProse: Codable, Identifiable {
    
    let id = UUID()
    
    let move_effect_id: Int?
    let local_language_id: Int?
    let short_effect: String? 
//    let damage_class_id: Int
    
}

//"move_effect_id": 1,
//"local_language_id": 9,
//"short_effect": "Inflicts regular damage with no additional effect.",
//"effect": "Inflicts [regular damage]{mechanic:regular-damage}."
