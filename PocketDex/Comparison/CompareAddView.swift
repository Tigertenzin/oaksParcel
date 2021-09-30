//
//  CompareAddView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/13/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct CompareAddView: View {
    var pokemonList:  [Pokemon]
    @Binding var comparisonList: [Pokemon]
    @Binding var isPresented: Bool
    
    @State private var tempCompareList = [Pokemon]()
    @State private var searchText = ""
    @State private var pkmn1 = Pokemon()
    @State private var pkmn2 = Pokemon()
    @State private var pkmn3 = Pokemon()
    @State private var pkmn4 = Pokemon()
    @State private var pkmn5 = Pokemon()
    @State private var pkmn6 = Pokemon()
    @State private var show1 = false
    @State private var show2 = false
    @State private var show3 = false
    @State private var show4 = false
    @State private var show5 = false
    @State private var show6 = false
    
    @FetchRequest(entity: Team_1.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Team_1.name, ascending: true)]) var allTeams: FetchedResults<Team_1>
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Manually Select")) {
                    
                    if self.show1 {
                        Picker("Pokemon 1: ", selection: $pkmn1) {
                            SearchBar(text: $searchText)
                            ForEach(pokemonList[0...806].filter{
                            self.searchText.isEmpty ? true : $0.identifier.contains(self.searchText) }, id: \.self) {
                                    Text("\($0.id) - \($0.wrappedName)")
                                        .tag($0.id)
                            }
                        }
                        
                        if self.show2 {
                            HStack{
                                Picker("Pokemon 2: ", selection: $pkmn2) {
                                    SearchBar(text: $searchText)
                                    ForEach(pokemonList[0...806].filter{
                                    self.searchText.isEmpty ? true : $0.identifier.contains(self.searchText) }, id: \.self) {
                                            Text("\($0.id) - \($0.wrappedName)")
                                                .tag($0.id)
                                    }
                                }
                            }
                            .animation(.default)
                            
                            if self.show3 {
                                HStack{
                                    Picker("Pokemon 3: ", selection: $pkmn3) {
                                        SearchBar(text: $searchText)
                                        ForEach(pokemonList[0...806].filter{
                                        self.searchText.isEmpty ? true : $0.identifier.contains(self.searchText) }, id: \.self) {
                                                Text("\($0.id) - \($0.wrappedName)")
                                                    .tag($0.id)
                                        }
                                    }
                                }
                                .animation(.default)
                                
                                if self.show4 {
                                    HStack{
                                        Picker("Pokemon 4: ", selection: $pkmn4) {
                                            SearchBar(text: $searchText)
                                            ForEach(pokemonList[0...806].filter{
                                            self.searchText.isEmpty ? true : $0.identifier.contains(self.searchText) }, id: \.self) {
                                                    Text("\($0.id) - \($0.wrappedName)")
                                                        .tag($0.id)
                                            }
                                        }
                                    }
                                    
                                    if self.show5 {
                                        HStack{
                                            Picker("Pokemon 5: ", selection: $pkmn5) {
                                                SearchBar(text: $searchText)
                                                ForEach(pokemonList[0...806].filter{
                                                self.searchText.isEmpty ? true : $0.identifier.contains(self.searchText) }, id: \.self) {
                                                        Text("\($0.id) - \($0.wrappedName)")
                                                            .tag($0.id)
                                                }
                                            }
                                        }
                                        
                                        if self.show6 {
                                            HStack{
                                                Picker("Pokemon 6: ", selection: $pkmn6) {
                                                    SearchBar(text: $searchText)
                                                    ForEach(pokemonList[0...806].filter{
                                                    self.searchText.isEmpty ? true : $0.identifier.contains(self.searchText) }, id: \.self) {
                                                            Text("\($0.id) - \($0.wrappedName)")
                                                                .tag($0.id)
                                                    }
                                                }
                                            }
                                        } else {
                                            Button(action: {
                                                if self.comparisonList.count < 6 {
                                                    self.show6 = true
                                                }
                                            }) {
                                                HStack {
                                                    Image(systemName: "plus.circle.fill")
                                                    Text("Add Another")
                                                }
                                            }
                                            .hoverEffect(.lift)
                                            .animation(.default)
                                        }
                                    } else {
                                        Button(action: {
                                            if self.comparisonList.count < 6 {
                                                self.show5 = true
                                            }
                                        }) {
                                            HStack {
                                                Image(systemName: "plus.circle.fill")
                                                Text("Add Another")
                                            }
                                        }
                                        .hoverEffect(.lift)
                                        .animation(.default)
                                    }
                                    
                                } else {
                                    Button(action: {
                                        if self.comparisonList.count < 6 {
                                            self.show4 = true
                                        }
                                    }) {
                                        HStack {
                                            Image(systemName: "plus.circle.fill")
                                            Text("Add Another")
                                        }
                                    }
                                    .hoverEffect(.lift)
                                    .animation(.default)
                                }
                                
                            } else {
                                Button(action: {
                                    if self.comparisonList.count < 6 {
                                        self.show3 = true
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: "plus.circle.fill")
                                        Text("Add Another")
                                    }
                                }
                                .hoverEffect(.lift)
                                .animation(.default)
                            }
                            
                        } else {
                            Button(action: {
                                if self.comparisonList.count < 6 {
                                    self.show2 = true
                                }
                            }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                    Text("Add Another")
                                }
                            }
                            .hoverEffect(.lift)
                            .animation(.default)
                        }
                    } else {
                        Button(action: {
                            if self.comparisonList.count < 6 {
                                self.show1 = true
                            }
                        }) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                Text("Add A Pokemon")
                            }
                        }
                        .hoverEffect(.lift)
                        .animation(.default)
                    }
                }
                
                Section(header: Text("Other Options")){
//                    if allTeams.count > 0 {
//                        Picker("Select a Team: ", selection: $selectedTeam) {
//                            SearchBar(text: $searchText)
//                            ForEach(allTeams, id: \.id) { team in
//                                VStack(alignment: .leading) {
//                                    Text("\(team.name ?? "Unknown Name")")
//                                        .font(.headline)
//                                    
//                                    HStack{
//                                        Image(self.pokemonList[Int(team.pkmn1ID)-1].imgName)
//                                        Image(self.pokemonList[Int(team.pkmn2ID)-1].imgName)
//                                        Image(self.pokemonList[Int(team.pkmn3ID)-1].imgName)
//                                        Image(self.pokemonList[Int(team.pkmn4ID)-1].imgName)
//                                        Image(self.pokemonList[Int(team.pkmn5ID)-1].imgName)
//                                        Image(self.pokemonList[Int(team.pkmn6ID)-1].imgName)
//                                        Spacer()
//                                    }
//                                }
//                            }
//                        }
//                    }
                    
                    Button(action: {
                        if self.comparisonList.count < 6 {
                            self.comparisonList.append(self.pokemonList[Int.random(in: 0 ..< 808)])
                        }
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add a random Pokemon")
                                .fontWeight(.semibold)
                        }
                        .hoverEffect(.lift)
                    }
                }
                
                Section(header: Text("Currently Comparing")) {
                    ForEach(comparisonList, id: \.self) { pkmn in
                        HStack{
                            Image(pkmn.imgName)
                            Text(pkmn.wrappedName)
                        }
                        
                        if show1 {
                            HStack{
                                Image(self.pkmn1.imgName)
                                Text(self.pkmn1.wrappedName)
                            }
                        }
                        if show2 {
                            HStack{
                                Image(self.pkmn2.imgName)
                                Text(self.pkmn2.wrappedName)
                            }
                        }
                        if show3 {
                            HStack{
                                Image(self.pkmn3.imgName)
                                Text(self.pkmn3.wrappedName)
                            }
                        }
                        if show4 {
                            HStack{
                                Image(self.pkmn4.imgName)
                                Text(self.pkmn4.wrappedName)
                            }
                        }
                        if show5 {
                            HStack{
                                Image(self.pkmn5.imgName)
                                Text(self.pkmn5.wrappedName)
                            }
                        }
                        if show6 {
                            HStack{
                                Image(self.pkmn6.imgName)
                                Text(self.pkmn6.wrappedName)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Choose Comparison")
            .navigationBarItems(
                leading: Button("Cancel") {
                    self.isPresented = false
                },
                trailing: Button("Done") {
                    if self.show1 {
                        self.comparisonList.append(self.pkmn1)
                    }
                    if self.show2 {
                        self.comparisonList.append(self.pkmn2)
                    }
                    if self.show3 {
                        self.comparisonList.append(self.pkmn3)
                    }
                    if self.show4 {
                        self.comparisonList.append(self.pkmn4)
                    }
                    if self.show5 {
                        self.comparisonList.append(self.pkmn5)
                    }
                    if self.show6 {
                        self.comparisonList.append(self.pkmn6)
                    }
                    self.isPresented = false
                }.hoverEffect(.lift)
            )
        }
    }
}

//struct CompareAddView_Previews: PreviewProvider {
//    static var previews: some View {
//        CompareAddView()
//    }
//}
