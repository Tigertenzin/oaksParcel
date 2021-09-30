//
//  Ability.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/22/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation

struct Ability: Codable, Identifiable, Hashable {
    
    let id: Int
    let identifier: String
    let generation_id: Int?
    let is_main_series: Int?
    
    var wrappedName: String {
        return identifier.replacingOccurrences(of: "-", with: " ").capitalized
    }
    
    var serebiiURI: String {
        return "https://www.serebii.net/abilitydex/" + String(identifier.replacingOccurrences(of: "-", with: "")) + ".shtml"
    }
    
    init() {
        id = 0
        identifier = "Blank Ability"
        generation_id = 0
        is_main_series = 0
    }
    
}

//"identifier": "stench",
//"generation_id": 3,
//"is_main_series": 1


struct AbilityProse: Codable, Identifiable {
    let id = UUID()
    let ability_id: Int 
    let local_language_id: Int
    let short_effect: String
    let effect: String
    
    init() {
        ability_id = 0
        local_language_id=0
        short_effect = "N/A"
        effect = "N/A"
    }
}


//"ability_id": 1,
//"local_language_id": 9,
//"short_effect": "Has a 10% chance of making target Pokémon [flinch]{mechanic:flinch} with each hit.",
//"effect": "This Pokémon's damaging moves have a 10% chance to make the target [flinch]{mechanic:flinch} with each hit if they do not already cause flinching as a secondary effect.\n\nThis ability does not stack with a held item.\n\nOverworld: The wild encounter rate is halved while this Pokémon is first in the party."


struct PokemonAbilities: Codable, Identifiable, Hashable {
    let id = UUID()
    
    let pokemon_id: Int
    let ability_id: Int
    let is_hidden: Int
    let slot: Int
    
    var hidden_bool: Bool {
        if is_hidden == 1 {
            return true
        } else {
            return false
        }
    }
    
    init() {
        pokemon_id = 0
        ability_id = 0
        is_hidden = 0
        slot = 0
    }
}

//"pokemon_id": 1,
//"ability_id": 65,
//"is_hidden": 0,
//"slot": 1
