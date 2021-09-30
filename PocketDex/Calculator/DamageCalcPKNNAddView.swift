//
//  DamageCalcPKNNAddView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/8/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct DamageCalcPKNNAddView: View {
    var pokemonList:  [Pokemon]
    var moveList:  [Move]
    var abilityForPKMN: [Ability]
    
    @Binding var PKMN1: Pokemon
    @Binding var level1: Double
    @Binding var gender1: Int
    @Binding var ability1: Ability
    @Binding var nature1: Int
    @Binding var status1: Int
    @Binding var EVs1: [Double]
    @Binding var IVs1: [Double]
    @Binding var Mods1: [Double]
    @Binding var Move1_1: Move
    @Binding var Move2_1: Move
    @Binding var Move3_1: Move
    @Binding var Move4_1: Move
    
    var genderList = ["Male", "Female", "None"]
    var statTypeList = ["HP", "Atk.", "Def.", "Sp. Atk.", "Sp. Def.", "Speed"]
    var natureList = ["Hardy", "Lonely (+Atk, -Def)", "Brave (+Atk, -Spd)", "Adamant (+Atk, -SpA)", "Naughty (+Atk, -SpD)", "Bold (+Def, -Atk)", "Docile", "Relaxed (+Def, -Spd)", "Impish (+Def, -SpA)", "Lax (+Def, -SpD)", "Timid (+Spd, -Atk)", "Hasty (+Spd, -Def)", "Serious", "Jolly (+Spd, -SpA)", "Naive (+Spd, -SpD)", "Modest (+SpA, -Atk)", "Mild (+SpA, -Def)", "Quiet (+SpA, -Spd)", "Bashful", "Rash (+SpA, -SpD)", "Calm (+SpD, -Atk)", "Gentle (+SpD, -Def)", "Sassy (+SpD, -Spd)", "Careful (+SpD, -SpA)", "Quirky"]
    var statusList = ["Healthy", "Poisoned", "Badly Poisoned", "Burned", "Paralyzed", "Asleep", "Frozen"]
    
    @State private var searchText = ""
    
    @EnvironmentObject var selectedTheme: UserTheme
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit Pokemon")) {
                    Picker("Pokemon: ", selection: $PKMN1) {
                        SearchBar(text: $searchText)
                        ForEach(pokemonList.filter{
                        self.searchText.isEmpty ? true : $0.identifier.contains(self.searchText) }, id: \.self) {
                                Text("\($0.id) - \($0.wrappedName)")
                                    .tag($0.id)
                        }
                    }
                    HStack{
                        Image(self.PKMN1.imgName)
                        Text(self.PKMN1.wrappedName)
                    }
                }
                
                Section(header: Text("Details")) {
                    HStack{
                        Text("Level:")
                        Spacer()
                        Text("\(level1, specifier: "%g")")
                    }
                    Slider(value: $level1, in: 1...100, step: 1)
                    
                    Picker("Gender: ", selection: $gender1) {
                        ForEach(0...2, id: \.self) {
                            Text("\(genderList[$0])")
                        }
                    }
                    Picker("Ability: ", selection: $ability1) {
                        ForEach(abilityForPKMN, id: \.self) {
                            Text("\($0.wrappedName)")
                        }
                    }
                    
                    Picker("Nature: ", selection: $nature1) {
                        ForEach(0..<natureList.count, id: \.self) {
                            Text("\(natureList[$0])")
                        }
                    }
                    Picker("Status: ", selection: $status1) {
                        ForEach(0..<7, id: \.self) {
                            Text("\(statusList[$0])")
                        }
                    }
                }
                
                Section(header: Text("Move Selection")) {
                    
                    Picker("Move 1: ", selection: $Move1_1) {
                        SearchBar(text: $searchText)
                        ForEach(moveList.filter{
                        self.searchText.isEmpty ? true : $0.identifier.contains(self.searchText) }, id: \.self) {
                            Text("\($0.wrappedName): \($0.wrappedPower)")
                                .tag($0.id)
                            
                        }
                    }
                    Picker("Move 2: ", selection: $Move2_1) {
                        SearchBar(text: $searchText)
                        ForEach(moveList.filter{
                        self.searchText.isEmpty ? true : $0.identifier.contains(self.searchText) }, id: \.self) {
                            Text("\($0.wrappedName): \($0.wrappedPower)")
                                .tag($0.id)
                        }
                    }
                    Picker("Move 3: ", selection: $Move3_1) {
                        SearchBar(text: $searchText)
                        ForEach(moveList.filter{
                        self.searchText.isEmpty ? true : $0.identifier.contains(self.searchText) }, id: \.self) {
                            Text("\($0.wrappedName): \($0.wrappedPower)")
                                .tag($0.id)
                        }
                    }
                    Picker("Move 4: ", selection: $Move4_1) {
                        SearchBar(text: $searchText)
                        ForEach(moveList.filter{
                        self.searchText.isEmpty ? true : $0.identifier.contains(self.searchText) }, id: \.self) {
                            Text("\($0.wrappedName): \($0.wrappedPower)")
                                .tag($0.id)
                        }
                    }
                }
                
                Section(header: Text("EVs")) {
                    HStack{
                        Text("Total: ")
                        Spacer()
                        if EVs1.reduce(0, +) > 510 {
                            Text("\(EVs1.reduce(0, +), specifier: "%g")/510")
                                .foregroundColor(Color.red)
                        } else {
                            Text("\(EVs1.reduce(0, +), specifier: "%g")/510")
                        }
                    }
                    HStack{
                        Text("HP: \(EVs1[0], specifier: "%g")")
                        Slider(value: $EVs1[0], in: 0...252, step: 1)
                    }
                    HStack{
                        Text("Atk: \(EVs1[1], specifier: "%g")")
                        Slider(value: $EVs1[1], in: 0...252, step: 1)
                    }
                    HStack{
                        Text("Def: \(EVs1[2], specifier: "%g")")
                        Slider(value: $EVs1[2], in: 0...252, step: 1)
                    }
                    HStack{
                        Text("SpA: \(EVs1[3], specifier: "%g")")
                        Slider(value: $EVs1[3], in: 0...252, step: 1)
                    }
                    HStack{
                        Text("SpD: \(EVs1[4], specifier: "%g")")
                        Slider(value: $EVs1[4], in: 0...252, step: 1)
                    }
                    HStack{
                        Text("Spd: \(EVs1[5], specifier: "%g")")
                        Slider(value: $EVs1[5], in: 0...252, step: 1)
                    }
                }
                
                Section(header: Text("IVs")) {
                    HStack{
                        Text("HP: \(IVs1[0], specifier: "%g")")
                        Slider(value: $IVs1[0], in: 0...31, step: 1)
                    }
                    HStack{
                        Text("Atk: \(IVs1[1], specifier: "%g")")
                        Slider(value: $IVs1[1], in: 0...31, step: 1)
                    }
                    HStack{
                        Text("Def: \(IVs1[2], specifier: "%g")")
                        Slider(value: $IVs1[2], in: 0...31, step: 1)
                    }
                    HStack{
                        Text("SpA: \(IVs1[3], specifier: "%g")")
                        Slider(value: $IVs1[3], in: 0...31, step: 1)
                    }
                    HStack{
                        Text("SpD: \(IVs1[4], specifier: "%g")")
                        Slider(value: $IVs1[4], in: 0...31, step: 1)
                    }
                    HStack{
                        Text("Spd: \(IVs1[5], specifier: "%g")")
                        Slider(value: $IVs1[5], in: 0...31, step: 1)
                    }
                }
                
                Section(header: Text("Modifiers")) {
                    HStack{
                        Text("HP: \(Mods1[0], specifier: "%g")")
                        Slider(value: $Mods1[0], in: -6...6, step: 1)
                    }
                    HStack{
                        Text("Atk: \(Mods1[1], specifier: "%g")")
                        Slider(value: $Mods1[1], in: -6...6, step: 1)
                    }
                    HStack{
                        Text("Def: \(Mods1[2], specifier: "%g")")
                        Slider(value: $Mods1[2], in: -6...6, step: 1)
                    }
                    HStack{
                        Text("SpA: \(Mods1[3], specifier: "%g")")
                        Slider(value: $Mods1[3], in: -6...6, step: 1)
                    }
                    HStack{
                        Text("SpD: \(Mods1[4], specifier: "%g")")
                        Slider(value: $Mods1[4], in: -6...6, step: 1)
                    }
                    HStack{
                        Text("Spd: \(Mods1[5], specifier: "%g")")
                        Slider(value: $Mods1[5], in: -6...6, step: 1)
                    }
                }
            }
            .navigationBarTitle("Select Pokemon")
            .navigationBarItems(
                trailing: Button("Done") {
//                    PKMN1 = pkmnTemp
                    self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
