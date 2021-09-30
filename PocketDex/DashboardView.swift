//
//  DashboardView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/26/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var selectedTheme: UserTheme
    @EnvironmentObject var selectedVersion: UserVersion
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    // data in the form of lists of structs
    var pokemonList:  [Pokemon]
    var pokemonFormsList: [Pokemon_Forms]
    var pokemonSpeciesNameList:  [PokemonSpeciesName]
    var pokemonTypeList:  [PokemonType]
    var pokemonStatList:  [PokemonStat]
    var moveList:  [Move]
    var moveEffectList:  [MoveEffectProse]
    var typeList:  [Type]
    var abilityList:  [Ability]
    var abilityProseList:  [AbilityProse]
    var pokemonAbilitiesList:  [PokemonAbilities]
    var itemList:  [Item]
    var itemProseList:  [ItemProse]
    var locationList:  [Location]
    var locationAreasList:  [Location_Areas]
    var encountersList: [Encounters]
    var encounterSlotList: [EncountersSlot]
    
    @State private var showingSettingsView = false
    
    var body: some View {
        NavigationView{
            if horizontalSizeClass == .compact {
                SidebarCompact(pokemonList: self.pokemonList,
                        pokemonFormsList: pokemonFormsList,
                        pokemonTypeList: self.pokemonTypeList,
                        pokemonStatList: self.pokemonStatList,
                        moveList: self.moveList,
                        moveEffectList: self.moveEffectList,
                        typeList: self.typeList,
                        abilityList: self.abilityList,
                        abilityProseList: self.abilityProseList,
                        pokemonAbilitiesList: self.pokemonAbilitiesList,
                        itemList: self.itemList,
                        itemProseList: self.itemProseList,
                        locationList: self.locationList,
                        locationAreasList: self.locationAreasList,
                        encountersList: self.encountersList,
                        encounterSlotList: self.encounterSlotList)
            } else {
                Sidebar(pokemonList: self.pokemonList,
                        pokemonFormsList: pokemonFormsList,
                        pokemonTypeList: self.pokemonTypeList,
                        pokemonStatList: self.pokemonStatList,
                        moveList: self.moveList,
                        moveEffectList: self.moveEffectList,
                        typeList: self.typeList,
                        abilityList: self.abilityList,
                        abilityProseList: self.abilityProseList,
                        pokemonAbilitiesList: self.pokemonAbilitiesList,
                        itemList: self.itemList,
                        itemProseList: self.itemProseList,
                        locationList: self.locationList,
                        locationAreasList: self.locationAreasList,
                        encountersList: self.encountersList,
                        encounterSlotList: self.encounterSlotList)
            }
//            Sidebar(pokemonList: self.pokemonList,
//                    pokemonFormsList: pokemonFormsList,
//                    pokemonTypeList: self.pokemonTypeList,
//                    pokemonStatList: self.pokemonStatList,
//                    moveList: self.moveList,
//                    moveEffectList: self.moveEffectList,
//                    typeList: self.typeList,
//                    abilityList: self.abilityList,
//                    abilityProseList: self.abilityProseList,
//                    pokemonAbilitiesList: self.pokemonAbilitiesList,
//                    itemList: self.itemList,
//                    itemProseList: self.itemProseList,
//                    locationList: self.locationList,
//                    locationAreasList: self.locationAreasList,
//                    encountersList: self.encountersList,
//                    encounterSlotList: self.encounterSlotList)
            
            DexView(pokemonList: self.pokemonList,
                    pokemonFormsList: pokemonFormsList,
                    pokemonTypeList: self.pokemonTypeList,
                    moveList: self.moveList,
                    moveEffectList: self.moveEffectList,
                    typeList: self.typeList,
                    abilityList: self.abilityList,
                    abilityProseList: self.abilityProseList,
                    pokemonAbilitiesList: self.pokemonAbilitiesList,
                    itemList: self.itemList, 
                    sorting: .number,
                    order: .forward)
            
            WelcomeDexView(pokemonList: self.pokemonList)
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}
