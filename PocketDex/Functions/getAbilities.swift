//
//  getAbilities.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/10/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation

func getAbilities(pokemonAbilitiesList: [PokemonAbilities], pkmnID: Int) -> [PokemonAbilities] {
    var finalList = [PokemonAbilities]()
    
    if let j = pokemonAbilitiesList.firstIndex(where: {$0.pokemon_id == pkmnID}) {
        finalList.append(pokemonAbilitiesList[j])
        if pokemonAbilitiesList[j+1].pokemon_id == pkmnID {
            finalList.append(pokemonAbilitiesList[j+1])
        }
        if pokemonAbilitiesList[j+2].pokemon_id == pkmnID {
            finalList.append(pokemonAbilitiesList[j+2])
        }
    }
    
    return finalList
}


func findAbilites(pokemonAbilities: [PokemonAbilities], abilityList: [Ability]) -> [Ability] {
    var finalAbilitiesList = [Ability]()
    
    for pkmnAbility in pokemonAbilities {
        if let i = abilityList.firstIndex(where: {$0.id == pkmnAbility.ability_id }) {
            finalAbilitiesList.append(abilityList[i])
        }
    }
    return finalAbilitiesList
}
 
