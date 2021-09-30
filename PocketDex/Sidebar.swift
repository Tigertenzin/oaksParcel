//
//  Sidebar.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/18/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct Sidebar: View {
    
    var pokemonList:  [Pokemon]
    var pokemonFormsList: [Pokemon_Forms]
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
    @EnvironmentObject var selectedTheme: UserTheme
    @EnvironmentObject var selectedVersion: UserVersion
    @EnvironmentObject var iconSettings : IconNames
    
    var body: some View {
        List {
            Section(header: Text("Lists")) {
                NavigationLink(destination: DexView(pokemonList: self.pokemonList,
                                                    pokemonFormsList: self.pokemonFormsList,
                                                    pokemonTypeList: self.pokemonTypeList,
                                                    moveList: self.moveList,
                                                    moveEffectList: self.moveEffectList,
                                                    typeList: self.typeList,
                                                    abilityList: self.abilityList,
                                                    abilityProseList: self.abilityProseList,
                                                    pokemonAbilitiesList: self.pokemonAbilitiesList,
                                                    itemList: self.itemList,
                                                    sorting: .number,
                                                    order: .forward)) {
                    HStack{
                        Image(systemName: "ant")
                            .foregroundColor(selectedTheme.themeColor)
                        Text("List of Pokemon")
                    }
                }
                
                NavigationLink(destination: MovesView(pokemonList: self.pokemonList,
                                                      pokemonFormsList: self.pokemonFormsList,
                                                      pokemonTypeList: self.pokemonTypeList,
                                                      moveList: self.moveList,
                                                      moveEffectList: self.moveEffectList,
                                                      typeList: self.typeList,
                                                      abilityList: self.abilityList,
                                                      abilityProseList: self.abilityProseList,
                                                      pokemonAbilitiesList: self.pokemonAbilitiesList,
                                                      itemList: self.itemList,
                                                      sorting: .number,
                                                      order: .forward)) {
                    HStack{
                        Image(systemName: "flame")
                            .foregroundColor(selectedTheme.themeColor)
                        Text("List of Moves")
                    }
                }
                
                NavigationLink(destination: AbilityView(pokemonList: self.pokemonList,
                                                        pokemonFormsList: self.pokemonFormsList,
                                                        pokemonTypeList: self.pokemonTypeList,
                                                        moveList: self.moveList,
                                                        moveEffectList: self.moveEffectList,
                                                        typeList: self.typeList,
                                                        abilityList: self.abilityList,
                                                        abilityProseList: self.abilityProseList,
                                                        pokemonAbilitiesList: self.pokemonAbilitiesList,
                                                        itemList: self.itemList,
                                                        sorting: .number,
                                                        order: .forward)) {
                    HStack{
                        Image(systemName: "heart")
                            .foregroundColor(selectedTheme.themeColor)
                        Text("List of Abilities")
                    }
                }
                
                NavigationLink(destination: ItemView(itemList: self.itemList,
                                                     itemProseList: self.itemProseList,
                                                     sorting: .number,
                                                     order: .forward)) {
                    HStack{
                        Image(systemName: "cube.box")
                            .foregroundColor(selectedTheme.themeColor)
                        Text("List of Items")
                    }
                }
                
                NavigationLink(destination: LocationsView(pokemonList: pokemonList,
                                                          locationList: locationList,
                                                          locationAreasList: locationAreasList,
                                                          encountersList: encountersList,
                                                          encounterSlotList: encounterSlotList)) {
                    HStack{
                        Image(systemName: "location")
                            .foregroundColor(selectedTheme.themeColor)
                        Text("List of Locations")
                    }
                }
            }
            
            Section(header: Text("Extras")) {
                
                NavigationLink(destination: FavoritesListView(pokemonList: self.pokemonList,
                                                              pokemonFormsList: self.pokemonFormsList,
                                                              pokemonTypeList: self.pokemonTypeList,
                                                              moveList: self.moveList,
                                                              moveEffectList: self.moveEffectList,
                                                              typeList: self.typeList,
                                                              abilityList: self.abilityList,
                                                              abilityProseList: self.abilityProseList,
                                                              pokemonAbilitiesList: self.pokemonAbilitiesList,
                                                              itemList: self.itemList,
                                                              itemProseList: self.itemProseList)) {
                    HStack{
                        Image(systemName: "star.circle")
                            .foregroundColor(selectedTheme.themeColor)
                        Text("Favorites")
                    }
                }
                
                NavigationLink(destination: TeamListView(pokemonList: self.pokemonList,
                                                         pokemonFormsList: pokemonFormsList, 
                                                         pokemonTypeList: self.pokemonTypeList,
                                                         moveList: self.moveList,
                                                         moveEffectList: self.moveEffectList,
                                                         typeList: self.typeList,
                                                         abilityList: self.abilityList,
                                                         abilityProseList: self.abilityProseList,
                                                         pokemonAbilitiesList: self.pokemonAbilitiesList,
                                                         itemList: self.itemList,
                                                         pokemonStatList: self.pokemonStatList)) {
                    HStack{
                        Image(systemName: "person.2.square.stack")
                            .foregroundColor(selectedTheme.themeColor)
                        Text("Team Builder")
                    }
                }
                
                NavigationLink(destination: ChecklistListView(pokemonList: pokemonList)) {
                    HStack{
                        Image(systemName: "checkmark.square")
                            .foregroundColor(selectedTheme.themeColor)
                        Text("Living Dex Checklist")
                    }
                }
                
                NavigationLink(destination: CalcListView(pokemonList: self.pokemonList,
                                                         pokemonFormsList: self.pokemonFormsList, 
                                                         pokemonTypeList: self.pokemonTypeList,
                                                         pokemonStatList: self.pokemonStatList, 
                                                         moveList: self.moveList,
                                                         moveEffectList: self.moveEffectList,
                                                         typeList: self.typeList,
                                                         abilityList: self.abilityList,
                                                         abilityProseList: self.abilityProseList,
                                                         pokemonAbilitiesList: self.pokemonAbilitiesList,
                                                         itemList: self.itemList,
                                                         itemProseList: self.itemProseList)) {
                    HStack{
                        Image(systemName: "plusminus.circle")
                            .foregroundColor(selectedTheme.themeColor)
                        Text("Calculators")
                    }
                }
            }
        }
        .listStyle(SidebarListStyle())
        .navigationBarTitle("Oak's Parcel")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.showingSettingsView.toggle()
                }) {
                    Image(systemName: "gear")
                        .imageScale(.large)
                }
            }
        }
//        .foregroundColor(selectedTheme.themeColor)
        .fullScreenCover(isPresented: $showingSettingsView) {
            SettingsParentView(pokemonList: self.pokemonList)
                .environmentObject(selectedTheme)
                .environmentObject(selectedVersion)
                .environmentObject(iconSettings)
                .accentColor(selectedTheme.themeColor) 
        }
        
    }
}
