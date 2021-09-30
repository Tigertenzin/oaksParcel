//
//  getOtherForms.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/15/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation

func getOtherForms(inputPokemon: Pokemon, pokemonList: [Pokemon]) -> [Pokemon] {
    var resultForms = [Pokemon]()
    
    resultForms.append(inputPokemon)
    for pkmn in pokemonList[807..<pokemonList.count] {
        if pkmn.species_id==inputPokemon.species_id {
            resultForms.append(pkmn)
        }
    }
    
    return resultForms
}
