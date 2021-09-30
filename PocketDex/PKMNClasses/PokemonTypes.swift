//
//  File.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/14/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation

struct PokemonType: Codable, Hashable, Identifiable {
    
    let id = UUID() 
    let pokemon_id: Int
    let type_id: Int
    let slot: Int
    
}
