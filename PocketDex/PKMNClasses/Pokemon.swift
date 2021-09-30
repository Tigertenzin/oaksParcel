//
//  Pokemon.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/14/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Identifiable, Hashable {
    
    let id: Int
    let identifier: String
    let species_id: Int
    let height: Int
    let weight: Int
    let base_experience: Int
    let order: Int
    
    var imgName: String {
        if identifier == "MissingNo" {
            return String(0)
        } else {
            return String(id)
        }
    }
    
    var pkmnMovesName: String{
        return "pokemon_moves_" + String(format:"%03d", id)
    }
    
    var wrappedName: String {
        return identifier.capitalized
    }
    
    var wrappedHeight: Float {
        return Float(height)*0.1
    }
    
    var wrappedWeight: Float {
        return Float(weight) * 0.1
    }
    
    var serebiiURL: String{
        return "https://www.serebii.net/pokedex-sm/" + String(format: "%03d", id) + ".shtml"
    }
    
    var bulbapediaURL: String{
        return "https://bulbapedia.bulbagarden.net/wiki/\(wrappedName)_(Pokémon)"
    }
    
    var generationID: Int {
        if id < 152 {
            return 1
        } else if id < 252 {
            return 2
        } else if id < 387 {
            return 3
        } else if id < 494 {
            return 4
        } else if id < 650 {
            return 5
        } else if id < 722 {
            return 6
        } else if id < 810 {
            return 7
        } else {
            return 0
        }
    }
    
//    var languageNames: [PokemonSpeciesName] {
//        let pokemonSpeciesNameList:  [PokemonSpeciesName] = Bundle.main.decodeCSV("pokemon_species_names.csv")
//        return getSpeciesNames(inputSpecies_id: species_id, pokemonSpeciesNameList: pokemonSpeciesNameList)
//    }
    
    init() {
        id = 1
        identifier = "MissingNo"
        species_id = 1
        height = 1
        weight = 1
        base_experience = 1
        order = 35
    }
}

//id,identifier,species_id,height,weight,base_experience,order,is_default
//1,bulbasaur,1,7,69,64,1,1

//{
//  "id": 1,
//  "identifier": "bulbasaur",
//  "species_id": 1,
//  "height": 7,
//  "weight": 69,
//  "base_experience": 64,
//  "order": 1,
//  "is_default": 1
//},

//"id": 25,
//"identifier": "pikachu",
//"species_id": 25,
//"height": 4,
//"weight": 60,
//"base_experience": 112,
//"order": 35,
//"is_default": 1
