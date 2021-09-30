//
//  DetailView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/10/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI
import Foundation

struct DetailView: View {
    @EnvironmentObject var selectedVersion: UserVersion
    @EnvironmentObject var selectedTheme: UserTheme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: FavPkmn.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \FavPkmn.pkmnID, ascending: true)]) var allFavPkmn: FetchedResults<FavPkmn>
    
    var pokemonFormsList: [Pokemon_Forms]
    var pokemonTypeList:  [PokemonType]
    var typeList:  [Type]
    var pokemonList:  [Pokemon]
    var moveList:  [Move]
    var moveEffectList:  [MoveEffectProse]
    var abilityList:  [Ability]
    var abilityProseList:  [AbilityProse]
    var pokemonAbilitiesList:  [PokemonAbilities]
    var itemList: [Item]
//    var otherForms: [Pokemon]
    
    @State var pkmn: Pokemon
    
    var otherForms: [Pokemon] {
        getOtherForms(inputPokemon: pkmn, pokemonList: pokemonList)
    }
    
    var otherFormsDetails: [Pokemon_Forms] {
        return getOtherFormDets(otherForms: otherForms, pokemonFormsList: pokemonFormsList)
    }
    
    
    var versionFilter: Int {
        return selectedVersion.versionOrder
    }
    
    var pokemonMoveList: [PokemonMove] {
        let filename = pkmn.pkmnMovesName + "_\(String(format:"%02d", selectedVersion.versionOrder+1))" + ".csv"
        
        if Bundle.main.ifFileExists(filename) {
            return Bundle.main.decodeCSV(pkmn.pkmnMovesName + "_\(String(format:"%02d", selectedVersion.versionOrder+1))" + ".csv")
        } else {
            return [PokemonMove]()
        }
    }
    @State private var showingForms = true
    @State private var showingDetails = true
    @State private var showingStats = true
    @State private var showingTypes = true
    @State private var showingEvols = true
    @State private var showingAbilities = true
    @State private var showingMoves = true
    @State private var showingOtherMoves = true
    
    var showingAll: Bool {
        if showingStats==false {
            if showingDetails==false {
                if showingAbilities==false {
                    if showingMoves==false {
                        if showingOtherMoves == false {
                            return false
                        }
                    }
                }
            }
        }
        return true
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Spacer()
                    .frame(height: 16)
                    
                    Group {
                        // Header PKMN View
                        DetailHeaderView(pkmn: self.pkmn, pokemonTypeList: pokemonTypeList, typeList: typeList, otherForms: otherForms, otherFormsDetails: otherFormsDetails)
                        
                        // forms if more exist
//                        if otherFormsDetails.count > 1 {
//                            DetailFormsView(otherForms: otherForms, otherFormsDetails: otherFormsDetails, pkmn: self.$pkmn, showingForms: self.$showingForms)
//                        }
                        
                        // Details
                        DetailDetailView(pkmn: pkmn, showingDetails: self.$showingDetails)

                        // Stats
                        StatsView(pokemonTypeList: pokemonTypeList,
                                  typeList: typeList, 
                                  pkmnid: self.pkmn.id,
                                  showingStats: self.$showingStats)
                        
                        //Type matchups
                        DetailTypeMatchupView(pkmn: pkmn,
                                              pokemonTypeList: pokemonTypeList,
                                              typeList: typeList,
                                              showingTypes: self.$showingTypes)

                        // Display the evolution chain of the given pkmn
                        DetailEvoView(pkmn: self.$pkmn,
                                      pokemonFormsList: pokemonFormsList,
                                      pokemonTypeList: pokemonTypeList,
                                      typeList: typeList,
                                      pokemonList: pokemonList,
                                      moveList: moveList,
                                      moveEffectList: moveEffectList,
                                      abilityList: abilityList,
                                      abilityProseList: abilityProseList,
                                      pokemonAbilitiesList: pokemonAbilitiesList,
                                      itemList: itemList,
                                      showingEvols: self.$showingEvols)

                        
                        // Abilities
                        DetailAbilityView(pokemonList:pokemonList,
                                          pokemonFormsList: pokemonFormsList, 
                                          pokemonTypeList:pokemonTypeList,
                                          moveList:moveList,
                                          moveEffectList:moveEffectList,
                                          typeList:typeList,
                                          abilityList:abilityList,
                                          abilityProseList:abilityProseList,
                                          pokemonAbilitiesList:pokemonAbilitiesList,
                                          itemList: itemList,
                                          pkmnID: self.pkmn.id,
                                          showingAbilities: self.$showingAbilities)

                        // Level-up Moves
                        DetailLevelMovesView(pokemonList: pokemonList,
                                             pokemonFormsList: self.pokemonFormsList, 
                                             pokemonTypeList: pokemonTypeList,
                                             moveList: moveList,
                                             moveEffectList: moveEffectList,
                                             typeList: typeList,
                                             abilityList: abilityList,
                                             abilityProseList: abilityProseList,
                                             pokemonAbilitiesList: pokemonAbilitiesList,
                                             itemList: itemList,
                                             pokemonMoveList: self.pokemonMoveList,
                                             showingMoves: self.$showingMoves)

                        // Other Moves
                        if pokemonMoveList.count > 0 {
                            DetailOtherMovesView(pokemonList: pokemonList,
                                                 pokemonFormsList: pokemonFormsList,
                                                 pokemonTypeList: pokemonTypeList,
                                                 moveList: moveList,
                                                 moveEffectList: moveEffectList,
                                                 typeList: typeList,
                                                 abilityList: abilityList,
                                                 abilityProseList: abilityProseList,
                                                 pokemonAbilitiesList: pokemonAbilitiesList,
                                                 itemList: itemList,
                                                 pokemonMoveList: self.pokemonMoveList,
                                                 showingOtherMoves: self.$showingOtherMoves)
                        }
                    }
                    .padding()
                    .frame(width: geo.size.width)
                    .fixedSize(horizontal: false, vertical: true)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    .animation(.default)
                    
                    // Links to Serebii page and  Bulbapedia page
                    HStack{
                        Text("External Links: ")
                            .font(.caption)
                            .bold()
                        Spacer()
                    }
                    .padding(.vertical, 4)
                    VStack{
                        Button(action:{
                            if let url = URL(string: self.pkmn.serebiiURL) {
                                print(url)
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack{
                                Text("View on Serebii")
                                    .font(.headline)
                                Spacer()
                            }
                        }
//                        .padding(.bottom)
                        .hoverEffect()
                        
//                        Divider()
//
//                        Button(action:{
//                            if let url = URL(string: self.pkmn.bulbapediaURL) {
//                                print(url)
//                                UIApplication.shared.open(url)
//                            }
//                        }) {
//                            HStack{
//                                Text("View on Bulbapedia")
//                                    .font(.headline)
//                                Spacer()
//                            }
//                        }
//                        .padding(.bottom)
//                        .hoverEffect()
                    }
                }
            }
            .animation(.default)
            .navigationBarTitle("\(self.pkmn.wrappedName)")
//            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Section {
                            // button to add pokemon to Favorites
                            if allFavPkmn.contains{$0.pkmnID == pkmn.id && $0.type==1} {
                                Button(action: {
                                     print("already saved")
                                }) {
                                    Text("Added to favorites")
                                    Image(systemName: "star.fill")
                                }
                            } else {
                                Button(action: {
                                    let newFavPkmn = FavPkmn(context: self.moc)
                                    newFavPkmn.id = UUID()
                                    newFavPkmn.pkmnID = Int16(pkmn.id)
                                    newFavPkmn.type = 1 // Type1 = Pokemon
                                    try? self.moc.save()
                                    // print("saved, \(newTeam.name ?? "failed")")
                                }) {
                                    Text("Add to favorites")
                                    Image(systemName: "star")
                                }
                            }
                            
                            // button to hide/show all sections
                            Button(action: {
                                if self.showingAll {
                                    self.showingStats = false
                                    self.showingDetails = false
                                    self.showingAbilities = false
                                    self.showingMoves = false
                                    self.showingOtherMoves = false
                                    self.showingForms = false
                                    self.showingEvols = false
                                    self.showingTypes = false
                                } else {
                                    self.showingStats = true
                                    self.showingDetails = true
                                    self.showingAbilities = true
                                    self.showingMoves = true
                                    self.showingOtherMoves = true
                                    self.showingForms = true
                                    self.showingEvols = true
                                    self.showingTypes = true
                                }
                            }) {
                                if self.showingAll {
                                    Text("Collapse All")
                                    Image(systemName: "eye.slash")
                                } else {
                                    Text("Expand All")
                                    Image(systemName: "eye")
                                }
                            }
                        }
                        
                        Section {
                            if pkmn.id > 721 {
                                // if gen 7
                                ForEach(16...17, id: \.self) { versionOrder in
                                    Button(action: {
                                        self.selectedVersion.versionOrder = versionOrder
                                    }) {
                                        Text("Set to \(self.selectedVersion.versionNames[versionOrder])")
                                    }
                                }
                            } else if pkmn.id > 649 {
                                // if gen 6 or later
                                ForEach(14...17, id: \.self) { versionOrder in
                                    Button(action: {
                                        self.selectedVersion.versionOrder = versionOrder
                                    }) {
                                        Text("Set to \(self.selectedVersion.versionNames[versionOrder])")
                                    }
                                }
                            } else if pkmn.id > 493 {
                                // if gen 4 or later
                                ForEach(14...17, id: \.self) { versionOrder in
                                    Button(action: {
                                        self.selectedVersion.versionOrder = versionOrder
                                    }) {
                                        Text("Set to \(self.selectedVersion.versionNames[versionOrder])")
                                    }
                                }
                            } else if pkmn.id > 386 {
                                // if gen 4 or later
                                ForEach(9...17, id: \.self) { versionOrder in
                                    Button(action: {
                                        self.selectedVersion.versionOrder = versionOrder
                                    }) {
                                        Text("Set to \(self.selectedVersion.versionNames[versionOrder])")
                                    }
                                }
                            } else if pkmn.id > 251 {
                                // if gen 3 or later
                                ForEach(4...17, id: \.self) { versionOrder in
                                    Button(action: {
                                        self.selectedVersion.versionOrder = versionOrder
                                    }) {
                                        Text("Set to \(self.selectedVersion.versionNames[versionOrder])")
                                    }
                                }
                            } else if pkmn.id > 151 {
                                // if gen 2 or later
                                ForEach(2...17, id: \.self) { versionOrder in
                                    Button(action: {
                                        self.selectedVersion.versionOrder = versionOrder
                                    }) {
                                        Text("Set to \(self.selectedVersion.versionNames[versionOrder])")
                                    }
                                }
                            } else {
                                // if gen 2 or later
                                ForEach(0...17, id: \.self) { versionOrder in
                                    Button(action: {
                                        self.selectedVersion.versionOrder = versionOrder
                                    }) {
                                        Text("Set to \(self.selectedVersion.versionNames[versionOrder])")
                                    }
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .imageScale(.large)
                    }
                }
                
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: {
//                            self.presentationMode.wrappedValue.dismiss()
//                            }) {
//                                HStack {
//                                    Image(systemName: "chevron.left")
//                                        .foregroundColor(selectedTheme.themeColor)
//                                    Text("Back")
//                                }
//                            }
//                }
            }
        }
        .padding(.horizontal)
    }
    
    func getOtherFormDets(otherForms: [Pokemon], pokemonFormsList: [Pokemon_Forms]) -> [Pokemon_Forms] {
        var resultFormDets = [Pokemon_Forms]()
        
        for pkmn in otherForms {
            for pkmnForm in pokemonFormsList {
                if pkmnForm.pokemon_id==pkmn.id {
                    resultFormDets.append(pkmnForm)
                }
            }
        }
        return resultFormDets
    }
    
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
    
    func typeColor(type: String) -> Color {
        // Returns the type for a corresponding color.
        if type == "Bug" {
            return Color(red: 0.682, green: 0.737, blue: 0.129, opacity: 1.000)
        } else if type == "Dark" {
            return Color(red: 0.443, green: 0.345, blue: 0.286, opacity: 1.000)
        } else if type == "Dragon" {
            return Color(red: 0.463, green: 0.373, blue: 0.839, opacity: 1.000)
        } else if type == "Electric" {
            return Color(red: 0.988, green: 0.769, blue: 0.200, opacity: 1.000)
        } else if type == "Fairy" {
            return Color(red: 0.969, green: 0.706, blue: 0.969, opacity: 1.000)
        } else if type == "Fighting" {
            return Color(red: 0.655, green: 0.318, blue: 0.224, opacity: 1.000)
        } else if type == "Fire" {
            return Color(red: 0.969, green: 0.322, blue: 0.192, opacity: 1.000)
        } else if type == "Flying" {
            return Color(red: 0.620, green: 0.675, blue: 0.941, opacity: 1.000)
        } else if type == "Ghost" {
            return Color(red: 0.427, green: 0.427, blue: 0.612, opacity: 1.000)
        } else if type == "Grass" {
            return Color(red: 0.478, green: 0.804, blue: 0.318, opacity: 1.000)
        } else if type == "Ground" {
            return Color(red: 0.784, green: 0.659, blue: 0.329, opacity: 1.000)
        } else if type == "Ice" {
            return Color(red: 0.361, green: 0.808, blue: 0.910, opacity: 1.000)
        } else if type == "Normal" {
            return Color(red: 0.569, green: 0.545, blue: 0.498, opacity: 1.000)
        } else if type == "Poison" {
            return Color(red: 0.694, green: 0.361, blue: 0.639, opacity: 1.000)
        } else if type == "Psychic" {
            return Color(red: 0.859, green: 0.451, blue: 0.600, opacity: 1.000)
        } else if type == "Rock" {
            return Color(red: 0.733, green: 0.639, blue: 0.345, opacity: 1.000)
        } else if type == "Steel" {
            return Color(red: 0.678, green: 0.678, blue: 0.780, opacity: 1.000)
        } else if type == "Water" {
            return Color(red: 0.235, green: 0.561, blue: 0.894, opacity: 1.000)
        } else {
            return Color.black
        }
    }
}
