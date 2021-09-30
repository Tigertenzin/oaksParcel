//
//  Team.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/17/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation

struct Team: Identifiable, Codable{
    let id = UUID()
    var name: String
    
    var PKMN1: Pokemon
    var PKMN2: Pokemon
    var PKMN3: Pokemon
    var PKMN4: Pokemon
    var PKMN5: Pokemon
    var PKMN6: Pokemon
    
    var notes: String 
    
//    init() {
//        var pokemonList:  [Pokemon] = Bundle.main.decode("pokemon.json")
//        id = UUID()
//        name = ""
//        PKMN1 = pokemonList[24]
//        PKMN2 = pokemonList[24]
//        PKMN3 = pokemonList[24]
//        PKMN4 = pokemonList[24]
//        PKMN5 = pokemonList[24]
//        PKMN6 = pokemonList[24]
//    }
}


class Teams: ObservableObject {
    @Published var teams: [Team] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(teams) {
                UserDefaults.standard.set(encoded, forKey: "Teams")
            }
        }
    }
    init() {
        if let teams = UserDefaults.standard.data(forKey: "Teams") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Team].self, from:teams) {
                self.teams = decoded
                return
            }
        }
        self.teams = []
    }
}
