//
//  Location.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/23/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

struct Location: Codable, Identifiable, Hashable {
    let id: Int
    let region_id: Int?
    let identifier: String
    
    var wrappedName: String {
        return identifier.replacingOccurrences(of: "-", with: " ").capitalized
    }
    
    var regionName: String{
        if region_id == 1 {
            return "Kanto"
        } else if region_id == 2 {
            return "Johto"
        } else if region_id == 3 {
            return "Hoenn"
        } else if region_id == 4 {
            return "Sinnoh"
        } else if region_id == 5 {
            return "Unova"
        } else if region_id == 6 {
            return "Kalos"
        } else if region_id == 7 {
            return "Alola"
        } else {
            return "Other"
        }
    }
}

struct Location_Areas: Codable, Identifiable, Hashable {
    let id: Int
    let location_id: Int?
    let game_index: Int?
    let identifier: String?
    
    var wrappedName: String? {
        if identifier != nil {
            return identifier!.replacingOccurrences(of: "-", with: " ").capitalized
        } else {
            return nil
        }
    }
}


struct Encounters: Codable, Identifiable, Hashable {
    let id: Int
    let version_id: Int?
    let location_area_id: Int?
    let encounter_slot_id: Int
    let pokemon_id: Int?
    let min_level: Int?
    let max_level: Int?
}


struct EncountersSlot: Codable, Identifiable, Hashable {
    let id: Int
    let version_group_id: Int
    let encounter_method_id: Int
    let slot: Int?
    let rarity: Int
}
