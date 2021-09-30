//
//  types.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/6/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation

func typesName(id: Int) -> String {
    if id == 1 {
        return "normal"
    } else if id == 2 {
        return "fighting"
    } else if id == 3 {
        return "flying"
    } else if id == 4 {
        return "poison"
    } else if id == 5 {
        return "ground"
    }
    
    return ""
}

//[
// {
//   "id": 1,
//   "identifier": "normal",
//   "generation_id": 1,
//   "damage_class_id": 2
// },
// {
//   "id": 2,
//   "identifier": "fighting",
//   "generation_id": 1,
//   "damage_class_id": 2
// },
// {
//   "id": 3,
//   "identifier": "flying",
//   "generation_id": 1,
//   "damage_class_id": 2
// },
// {
//   "id": 4,
//   "identifier": "poison",
//   "generation_id": 1,
//   "damage_class_id": 2
// },
// {
//   "id": 5,
//   "identifier": "ground",
//   "generation_id": 1,
//   "damage_class_id": 2
// },
// {
//   "id": 6,
//   "identifier": "rock",
//   "generation_id": 1,
//   "damage_class_id": 2
// },
// {
//   "id": 7,
//   "identifier": "bug",
//   "generation_id": 1,
//   "damage_class_id": 2
// },
// {
//   "id": 8,
//   "identifier": "ghost",
//   "generation_id": 1,
//   "damage_class_id": 2
// },
// {
//   "id": 9,
//   "identifier": "steel",
//   "generation_id": 2,
//   "damage_class_id": 2
// },
// {
//   "id": 10,
//   "identifier": "fire",
//   "generation_id": 1,
//   "damage_class_id": 3
// },
// {
//   "id": 11,
//   "identifier": "water",
//   "generation_id": 1,
//   "damage_class_id": 3
// },
// {
//   "id": 12,
//   "identifier": "grass",
//   "generation_id": 1,
//   "damage_class_id": 3
// },
// {
//   "id": 13,
//   "identifier": "electric",
//   "generation_id": 1,
//   "damage_class_id": 3
// },
// {
//   "id": 14,
//   "identifier": "psychic",
//   "generation_id": 1,
//   "damage_class_id": 3
// },
// {
//   "id": 15,
//   "identifier": "ice",
//   "generation_id": 1,
//   "damage_class_id": 3
// },
// {
//   "id": 16,
//   "identifier": "dragon",
//   "generation_id": 1,
//   "damage_class_id": 3
// },
// {
//   "id": 17,
//   "identifier": "dark",
//   "generation_id": 2,
//   "damage_class_id": 3
// },
// {
//   "id": 18,
//   "identifier": "fairy",
//   "generation_id": 6,
//   "damage_class_id": null
// },
// {
//   "id": 10001,
//   "identifier": "unknown",
//   "generation_id": 2,
//   "damage_class_id": null
// },
// {
//   "id": 10002,
//   "identifier": "shadow",
//   "generation_id": 3,
//   "damage_class_id": null
// }
//]
