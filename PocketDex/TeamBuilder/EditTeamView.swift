//
//  EditTeamView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/24/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct EditTeamView: View {
    var pokemonList:  [Pokemon]
    
    @State var team: Team_1
    
    @State var name: String
    @State var note: String
    @State var pkmn1: Pokemon
    @State var pkmn2: Pokemon
    @State var pkmn3: Pokemon
    @State var pkmn4: Pokemon
    @State var pkmn5: Pokemon
    @State var pkmn6: Pokemon
    @State var set1: Bool
    @State var set2: Bool
    @State var set3: Bool
    @State var set4: Bool
    @State var set5: Bool
    @State var set6: Bool
    @State var versionOrderID: Int
    @State var searchText : String = ""
    
    @State private var versionNames = ["Red & Blue", "Yellow", "Gold & Silver", "Crystal", "Ruby & Sapphire", "Emerald", "Colosseum", "XD", "Fire Red & Leaf Green", "Diamond & Pearl", "Platinum", "Heart Gold & Soul Silver", "Black & White", "Black 2 & White 2", "X & Y", "Omega Ruby & Alpha Sapphire", "Sun & Moon", "Ultra Sun & Ultra Moon"]
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    
    var versionGeneration: Int {
        if versionOrderID < 2 {
            return 1
        } else {
            if versionOrderID < 4 {
                return 2
            } else {
                if versionOrderID < 9 {
                    return 3
                } else {
                    if versionOrderID < 12 {
                        return 4
                    } else {
                        if versionOrderID < 14 {
                            return 5
                        } else {
                            if versionOrderID < 16 {
                                return 6
                            } else {
                                return 7
                            }
                        }
                    }
                }
            }
        }
    }
    
    var validPokemonList: [Pokemon] {
        return Array(pokemonList[0...806]).filter{$0.generationID <= versionGeneration}
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Team Information")) {
                    FloatingTextField(title: "Team Name", text: self.$name)
                    
                    Picker("Version: ", selection: $versionOrderID) {
                        ForEach(1 ..< 19) {
                            Text("\(self.versionNames[$0-1])")
                            
                        }
                    }
                    
                }
                Section {
                    Picker("Pokemon 1: ", selection: $pkmn1) {
                        SearchBar(text: $searchText)
                        ForEach(validPokemonList.filter{
                        self.searchText.isEmpty ? true : $0.identifier.contains(self.searchText) }, id: \.self) {
                            Text("\($0.id) - \($0.wrappedName)")
                                .tag($0.id)
                        }
                    }
                    .onReceive([self.pkmn1].publisher.first()) { (value) in
                        print("changing Pokemon on team from default")
                        set1 = true
                    }
                    
                    Picker("Pokemon 2: ", selection: $pkmn2) {
                        SearchBar(text: $searchText)
                        ForEach(pokemonList[0...806].filter{
                        self.searchText.isEmpty ? true : $0.identifier.contains(self.searchText) }, id: \.self) {
                            Text("\($0.id) - \($0.wrappedName)")
                                .tag($0.id)
                        }
                    }
                    .onReceive([self.pkmn2].publisher.first()) { (value) in
                        print("changing Pokemon on team from default")
                        set2 = true
                    }
                        
                    Picker("Pokemon 3: ", selection: $pkmn3) {
                        SearchBar(text: $searchText)
                        ForEach(pokemonList[0...806].filter{
                        self.searchText.isEmpty ? true : $0.identifier.contains(self.searchText) }, id: \.self) {
                            Text("\($0.id) - \($0.wrappedName)")
                                .tag($0.id)
                        }
                    }
                    .onReceive([self.pkmn3].publisher.first()) { (value) in
                        print("changing Pokemon on team from default")
                        set3 = true
                    }
                    
                    Picker("Pokemon 4: ", selection: $pkmn4) {
                        SearchBar(text: $searchText)
                        ForEach(pokemonList[0...806].filter{
                        self.searchText.isEmpty ? true : $0.identifier.contains(self.searchText) }, id: \.self) {
                            Text("\($0.id) - \($0.wrappedName)")
                                .tag($0.id)
                        }
                    }
                    .onReceive([self.pkmn4].publisher.first()) { (value) in
                        print("changing Pokemon on team from default")
                        set4 = true
                    }
                    
                    Picker("Pokemon 5: ", selection: $pkmn5) {
                        SearchBar(text: $searchText)
                        ForEach(pokemonList[0...806].filter{
                        self.searchText.isEmpty ? true : $0.identifier.contains(self.searchText) }, id: \.self) {
                            Text("\($0.id) - \($0.wrappedName)")
                                .tag($0.id)
                        }
                    }
                    .onReceive([self.pkmn5].publisher.first()) { (value) in
                        print("changing Pokemon on team from default")
                        set5 = true
                    }
                    
                    Picker("Pokemon 6: ", selection: $pkmn6) {
                        SearchBar(text: $searchText)
                        ForEach(pokemonList[0...806].filter{
                        self.searchText.isEmpty ? true : $0.identifier.contains(self.searchText) }, id: \.self) {
                            Text("\($0.id) - \($0.wrappedName)")
                                .tag($0.id)
                        }
                    }
                    .onReceive([self.pkmn6].publisher.first()) { (value) in
                        print("changing Pokemon on team from default")
                        set6 = true
                    }

                    HStack{
                        Spacer()
                        VStack{
                            Image(pkmn1.imgName)
//                            Button(action: {
//                                self.pkmn1 = Pokemon()
//                                self.set1 = false
//                            }) {
//                                Image(systemName: "xmark.circle.fill")
//                            }
//                            .hoverEffect()
                        }
                        VStack{
                            Image(pkmn2.imgName)
//                            Button(action: {
//                                self.pkmn2 = Pokemon()
//                                self.set2 = false
//                            }) {
//                                Image(systemName: "xmark.circle.fill")
//                            }
//                            .hoverEffect()
                        }
                        VStack{
                            Image(pkmn3.imgName)
//                            Button(action: {
//                                self.pkmn3 = Pokemon()
//                                self.set3 = false
//                            }) {
//                                Image(systemName: "xmark.circle.fill")
//                            }
//                            .hoverEffect()
                        }
                        VStack{
                            Image(pkmn4.imgName)
//                            Button(action: {
//                                self.pkmn4 = Pokemon()
//                                self.set4 = false
//                            }) {
//                                Image(systemName: "xmark.circle.fill")
//                            }
//                            .hoverEffect()
                        }
                        VStack{
                            Image(pkmn5.imgName)
//                            Button(action: {
//                                self.pkmn5 = Pokemon()
//                                self.set5 = false
//                            }) {
//                                Image(systemName: "xmark.circle.fill")
//                            }
//                            .hoverEffect()
                        }
                        VStack{
                            Image(pkmn6.imgName)
//                            Button(action: {
//                                self.pkmn6 = Pokemon()
//                                self.set6 = false
//                            }) {
//                                Image(systemName: "xmark.circle.fill")
//                            }
//                            .hoverEffect()
                        }
                        Spacer()
                    }
                }
                
                Section(header: Text("Notes")){
                    TextEditor(text: $note)
                }
                
                Section{
                    Button("Save") {
                        team.name = self.name
                        team.pkmn1ID = Int16(self.pkmn1.id)
                        team.pkmn2ID = Int16(self.pkmn2.id)
                        team.pkmn3ID = Int16(self.pkmn3.id)
                        team.pkmn4ID = Int16(self.pkmn4.id)
                        team.pkmn5ID = Int16(self.pkmn5.id)
                        team.pkmn6ID = Int16(self.pkmn6.id)
                        team.note = self.note
                        team.versionOrderID = Int16(versionOrderID)
                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add new team")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        team.name = self.name
                        team.pkmn1ID = Int16(self.pkmn1.id)
                        team.pkmn2ID = Int16(self.pkmn2.id)
                        team.pkmn3ID = Int16(self.pkmn3.id)
                        team.pkmn4ID = Int16(self.pkmn4.id)
                        team.pkmn5ID = Int16(self.pkmn5.id)
                        team.pkmn6ID = Int16(self.pkmn6.id)
                        team.note = self.note
                        team.versionOrderID = Int16(versionOrderID)
                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Label("Cancel", systemImage: "xmark.circle.fill")
                    }
                }
            }
        }
    }
}
