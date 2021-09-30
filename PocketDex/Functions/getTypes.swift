//
//  getTypes.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/9/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation

func getTypes(typeList: [PokemonType], pkmnID: Int) -> [PokemonType] {
    var resultTypes = [PokemonType]()
    
    if let i = typeList.firstIndex(where: {$0.pokemon_id == pkmnID }) {
        resultTypes.append(typeList[i])
        if typeList[i+1].pokemon_id == pkmnID {
            resultTypes.append(typeList[i+1])
        }
    }
    return resultTypes
}
