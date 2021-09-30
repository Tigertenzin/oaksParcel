//
//  ContentView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/9/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import StoreKit

struct ContentView: View {
    
    @State private var selection = 0
    @EnvironmentObject var selectedTheme: UserTheme
    @EnvironmentObject var selectedVersion: UserVersion
    
    @State var show_modal = false
    
    var pokemonList:  [Pokemon] = Bundle.main.decodeCSV("pokemon.csv")
    var pokemonFormsList:  [Pokemon_Forms] = Bundle.main.decodeCSV("pokemon_forms.csv")
    var pokemonSpeciesNameList:  [PokemonSpeciesName] = Bundle.main.decodeCSV("pokemon_species_names.csv")
    var pokemonTypeList:  [PokemonType] = Bundle.main.decode("pokemon_types.json")
    var pokemonStatList:  [PokemonStat] = Bundle.main.decode("pokemon_stats.json")
    var moveList:  [Move] = Bundle.main.decode("moves.json")
    var moveEffectList:  [MoveEffectProse] = Bundle.main.decode("move_effect_prose.json")
    var typeList:  [Type] = Bundle.main.decode("types.json")
    var abilityList:  [Ability] = Bundle.main.decode("abilities.json")
    var abilityProseList:  [AbilityProse] = Bundle.main.decode("ability_prose.json")
    var pokemonAbilitiesList:  [PokemonAbilities] = Bundle.main.decode("pokemon_abilities.json")
    var itemList:  [Item] = Bundle.main.decodeCSV("items.csv")
    var itemProseList:  [ItemProse] = Bundle.main.decodeCSV("item_prose.csv")
    var locationList:  [Location] = Bundle.main.decodeCSV("locations.csv")
    var locationAreasList:  [Location_Areas] = Bundle.main.decodeCSV("location_areas.csv")
    var encountersList: [Encounters] = Bundle.main.decodeCSV("encounters.csv")
    var encounterSlotList: [EncountersSlot] = Bundle.main.decodeCSV("encounter_slots.csv")
    
    var body: some View {
        DashboardView(pokemonList: pokemonList,
                      pokemonFormsList: pokemonFormsList,
                      pokemonSpeciesNameList: pokemonSpeciesNameList,
                      pokemonTypeList: pokemonTypeList,
                      pokemonStatList: pokemonStatList,
                      moveList: moveList,
                      moveEffectList: moveEffectList,
                      typeList: typeList, 
                      abilityList: abilityList,
                      abilityProseList: abilityProseList,
                      pokemonAbilitiesList: pokemonAbilitiesList,
                      itemList: itemList,
                      itemProseList: itemProseList,
                      locationList: locationList,
                      locationAreasList: locationAreasList,
                      encountersList: encountersList,
                      encounterSlotList: encounterSlotList)
            .accentColor(selectedTheme.themeColor)
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
