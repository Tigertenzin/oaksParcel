//
//  File.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/14/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation

struct PokemonMove: Codable, Identifiable {

    let id = UUID()

    var pokemon_id: Int
    var version_group_id: Int
    var move_id: Int
    var pokemon_move_method_id: Int
    var level: Int
    var order: Float? 

}

//pokemon_id,version_group_id,move_id,pokemon_move_method_id,level,order
//1,1,14,4,0,
