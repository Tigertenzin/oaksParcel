//
//  PokemonStats.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/14/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation

struct PokemonStat: Codable, Identifiable {
    
    let id = UUID()
    
    let pokemon_id: Int
    let stat_id: Int
    let base_stat: Int
    let effort: Int
    
}

//"pokemon_id": 1,
//"stat_id": 1,
//"base_stat": 45,
//"effort": 0
