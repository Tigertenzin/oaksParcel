//
//  PokemonSpecies.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/15/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation

struct PokemonSpecies: Codable, Identifiable {
    
    let id: Int
    let identifier: String
    let generation_id: Int
    let evolves_from_species_id: Int?
    let evolution_chain_id: Int
    
    let color_id: Int
    let shape_id: Int 
    let gender_rate: Int
    let capture_rate: Int
    let base_happiness: Int
    let growth_rate_id: Int
    
    var growth_rate_prose: String {
        if growth_rate_id == 1 {
            return "Slow"
        } else if growth_rate_id == 2 {
            return "Medium"
        } else if growth_rate_id == 3 {
            return "Fast"
        } else if growth_rate_id == 4 {
            return "Medium Slow"
        } else if growth_rate_id == 5 {
            return "Erratic"
        } else if growth_rate_id == 6 {
            return "Fluctuating"
        } else {
            return "N/A"
        }
    }
    
    var wrappedName: String {
        return identifier.capitalizingFirstLetter()
    }
    
    var imgName: String {
        return String(id)
    }
    
}


//"id": 1,
//"identifier": "bulbasaur",
//"generation_id": 1,
//"evolves_from_species_id": null,
//"evolution_chain_id": 1,
//"color_id": 5,
//"shape_id": 8,
//"habitat_id": 3,
//"gender_rate": 1,
//"capture_rate": 45,
//"base_happiness": 70,
//"is_baby": 0,
//"hatch_counter": 20,
//"has_gender_differences": 0,
//"growth_rate_id": 4,
//"forms_switchable": 0,
//"order": 1,
//"conquest_order": null
