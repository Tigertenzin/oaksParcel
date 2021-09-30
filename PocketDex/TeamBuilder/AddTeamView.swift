//
//  AddTeamView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/17/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI
import Combine

struct AddTeamView: View {
    var pokemonList:  [Pokemon]
    
    @State private var name = ""
    @State private var note = ""
    @State private var pkmn1 = Pokemon()
    @State private var pkmn2 = Pokemon()
    @State private var pkmn3 = Pokemon()
    @State private var pkmn4 = Pokemon()
    @State private var pkmn5 = Pokemon()
    @State private var pkmn6 = Pokemon()
    @State private var versionOrderID = 1
    @State private var searchText : String = ""
    
    @State private var set1 = false
    @State private var set2 = false
    @State private var set3 = false
    @State private var set4 = false
    @State private var set5 = false
    @State private var set6 = false
    
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
                        let newTeam = Team_1(context: self.moc)
                        newTeam.id = UUID()
                        newTeam.name = self.name
                        newTeam.pkmn1ID = Int16(self.pkmn1.id)
                        newTeam.pkmn2ID = Int16(self.pkmn2.id)
                        newTeam.pkmn3ID = Int16(self.pkmn3.id)
                        newTeam.pkmn4ID = Int16(self.pkmn4.id)
                        newTeam.pkmn5ID = Int16(self.pkmn5.id)
                        newTeam.pkmn6ID = Int16(self.pkmn6.id)
                        newTeam.set1 = set1
                        newTeam.set2 = set2
                        newTeam.set3 = set3
                        newTeam.set4 = set4
                        newTeam.set5 = set5
                        newTeam.set6 = set6
                        newTeam.note = self.note
                        newTeam.versionOrderID = Int16(versionOrderID)
                        try? self.moc.save()
                        // print("saved, \(newTeam.name ?? "failed")")
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add new team")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        let newTeam = Team_1(context: self.moc)
                        newTeam.id = UUID()
                        newTeam.name = self.name
                        newTeam.pkmn1ID = Int16(self.pkmn1.id)
                        newTeam.pkmn2ID = Int16(self.pkmn2.id)
                        newTeam.pkmn3ID = Int16(self.pkmn3.id)
                        newTeam.pkmn4ID = Int16(self.pkmn4.id)
                        newTeam.pkmn5ID = Int16(self.pkmn5.id)
                        newTeam.pkmn6ID = Int16(self.pkmn6.id)
                        newTeam.note = self.note
                        newTeam.versionOrderID = Int16(versionOrderID)
                        try? self.moc.save()
                        // print("saved, \(newTeam.name ?? "failed")")
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
//
//
//
//struct AddTeamView_Previews: PreviewProvider {
//    var pokemonList:  [Pokemon] = Bundle.main.decode("pokemon.json")
//
//    static var previews: some View {
//        AddTeamView(teamList: Teams())
//    }
//}

