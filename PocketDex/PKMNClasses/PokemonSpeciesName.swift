//
//  PokemonSpeciesName.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/20/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation

struct PokemonSpeciesName: Codable, Identifiable {
    
    let id = UUID()
    let pokemon_species_id: Int?
    let local_language_id: Int?
    let name: String?
    let genus: String?
}



func getSpeciesNames(inputSpecies_id: Int, pokemonSpeciesNameList: [PokemonSpeciesName]) -> [PokemonSpeciesName] {
    var resultSpeciesNames = [PokemonSpeciesName]()
    
    if let i = pokemonSpeciesNameList.firstIndex(where: {$0.pokemon_species_id == inputSpecies_id}) {
        for possibleSpecies in pokemonSpeciesNameList[i..<i+12] {
            if possibleSpecies.pokemon_species_id==inputSpecies_id {
                resultSpeciesNames.append(possibleSpecies)
            }
        }
    }
    return resultSpeciesNames
}
