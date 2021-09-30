//
//  PokemonEvol.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/16/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation

struct Pokemon_Evol : Codable, Identifiable, Hashable {
    let id: Int
    let evolved_species_id: Int
    let evolution_trigger_id: Int
    let trigger_item_id: Int?
    let minimum_level: Int?
    let gender_id: Int?
    let location_id: Int?
    let held_item_id: Int?
    let time_of_day: String?
    let known_move_id: Int?
    let known_move_type_id: Int?
    let minimum_happiness: Int?
    let minumum_beauty: Int?
    let minimum_affection: Int?
    let relative_physical_stats: Int?
    let party_species_id: Int?
    let party_type_id: Int?
    let trade_species_id: Int?
    let needs_overworld_rain: Int
    let turn_upside_down: Int
}
