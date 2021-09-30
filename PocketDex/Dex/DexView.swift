//
//  DexView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/9/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

enum SortType: String, CaseIterable {
    case number, name, height, weight
}

enum OrderType: String, CaseIterable {
    case forward, backward
}

struct DexView: View {
    @EnvironmentObject var selectedVersion: UserVersion
    
    var pokemonList:  [Pokemon]
    var pokemonFormsList: [Pokemon_Forms]
    var pokemonTypeList:  [PokemonType]
    var moveList:  [Move]
    var moveEffectList:  [MoveEffectProse]
    var typeList:  [Type]
    var abilityList:  [Ability]
    var abilityProseList:  [AbilityProse]
    var pokemonAbilitiesList:  [PokemonAbilities]
    var itemList: [Item]
    
    @State private var showSheetView = false
    @State private var searchText : String = ""
    @State var sorting: SortType
    @State var order: OrderType
    @State var typeFilter: Int = 1
    @State var genFilter: Int = 1
    @State var showingTypeFilter = false
    @State var showingGenFilter = false
    @State var inclusiveGenFilter = false
    
    @EnvironmentObject var selectedTheme: UserTheme
    
//    var otherFormsList: [Pokemon] {
//        return Array(pokemonList[807..<pokemonList.count])
//    }
    
    var filteredPokemonList_Type: [Pokemon] {
        if showingTypeFilter {
            return Array(pokemonList[0...806]).filter{self.checkTypeExists(typeList: pokemonTypeList, pkmnID: $0.id, checkType: typeFilter)}
        } else {
            return Array(pokemonList[0...806])
        }
    }
    
    var filteredPokemonList_Gen: [Pokemon] {
        if showingGenFilter {
            if inclusiveGenFilter {
                return Array(filteredPokemonList_Type).filter{$0.generationID <= self.genFilter}
            } else {
                return Array(filteredPokemonList_Type).filter{$0.generationID == self.genFilter}
            }
        } else {
            return Array(filteredPokemonList_Type).filter{$0.generationID <= self.selectedVersion.versionGen}
        }
    }
    
    var sortedPokemonList: [Pokemon] {
        switch sorting {
        case .number:
            return filteredPokemonList_Gen.sorted{$0.id < $1.id}
        case .name:
            return filteredPokemonList_Gen.sorted{$0.wrappedName < $1.wrappedName}
        case .height:
            return filteredPokemonList_Gen.sorted{$0.height < $1.height}
        case .weight:
            return filteredPokemonList_Gen.sorted{$0.weight < $1.weight}
        }
    }
    
    var orderedPokemonList: [Pokemon] {
        switch order {
        case .forward:
            return sortedPokemonList
        case .backward:
            return sortedPokemonList.reversed()
        }
    }
    
    var searchedPokemonList: [Pokemon] {
        if selectedVersion.noSearchExact {
            return Array(orderedPokemonList.filter{self.searchText.isEmpty ? true : $0.identifier.contains(self.searchText) || $0.id == Int(self.searchText) })
        } else {
            return Array(orderedPokemonList.filter{self.searchText.isEmpty ? true : $0.identifier.contains(self.searchText) || String($0.id).contains(self.searchText) })
        }
    }
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(.horizontal, 4)
            
            List(searchedPokemonList) { pkmn in
                NavigationLink(destination: DetailView(pokemonFormsList: pokemonFormsList,
                                                       pokemonTypeList: pokemonTypeList,
                                                       typeList: typeList,
                                                       pokemonList: pokemonList,
                                                       moveList: moveList,
                                                       moveEffectList: moveEffectList,
                                                       abilityList: abilityList,
                                                       abilityProseList: abilityProseList,
                                                       pokemonAbilitiesList: pokemonAbilitiesList,
                                                       itemList: itemList, 
//                                                       otherForms: getOtherForms(inputPokemon: pkmn, pokemonList: pokemonList),
                                                       pkmn: pkmn)) {
                    DexViewRow(pkmn: pkmn, pkmnTypeList: self.getTypes(typeList: self.pokemonTypeList, pkmnID: pkmn.id), typeList: typeList)
                }
            }
            .id(UUID())
            .animation(.interactiveSpring())
        }
        .navigationBarTitle("Pokedex")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.showSheetView.toggle()
                }) {
                    Label("Filter List", systemImage: "arrow.up.arrow.down.circle.fill")
                }
            }
        }
        .sheet(isPresented: self.$showSheetView) {
            NavigationView {
                 Form {
                    Section(header: Text("Order...")) {
                        Picker(selection: self.$order, label: Text("Ordering: ")) {
                            ForEach(OrderType.allCases, id: \.self) {
                                Text("\($0.rawValue)")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                        
                    Section(header: Text("Sort by...")) {
                        Picker(selection: self.$sorting, label: Text("Choose to sort by: ")) {
                            ForEach(SortType.allCases, id: \.self) {
                                Text("\($0.rawValue)")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Section(header: Text("Filter by...")) {
                        Toggle(isOn: self.$showingTypeFilter.animation()) {
                            Text("Filter by type?")
                        }
                        
                        if self.showingTypeFilter {
                                Picker(selection: self.$typeFilter, label: EmptyView()) {
                                    ForEach(1...20, id: \.self) {
                                        Text("\(self.typeList[$0-1].wrappedName)").frame(width: 64, height: 28).background(typeColor(type: self.typeList[$0-1].wrappedName)).cornerRadius(6).font(.caption)
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                        }
                        
                        Toggle(isOn: self.$showingGenFilter.animation()) {
                            Text("Filter by Generation?")
                        }
                        
                        if self.showingGenFilter {
                            Picker(selection: self.$genFilter, label: EmptyView()) {
                                    ForEach(1...7, id: \.self) {
                                        Text("Gen \($0)")
                                    }
                            }
                            .pickerStyle(WheelPickerStyle())
                            
                            Toggle(isOn: self.$inclusiveGenFilter) {
                                Text("Include previous generations?")
                            }
                            
                        }
                    }
                    
                    Section(header: Text("Defaults")) {
                        Button(action: {
                            self.order = OrderType.forward
                            self.sorting = SortType.number
                            self.showingTypeFilter = false
                            self.showingGenFilter = false
                            self.inclusiveGenFilter = false
                            self.showSheetView = false
                        }) {
                            HStack {
                                Spacer()
                                Text("Set to default")
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            .padding()
                        }.hoverEffect()
                    }
                 }
                .navigationBarTitle(Text("Sort and Filter"), displayMode: .inline)
                 .toolbar {
                     ToolbarItem(placement: .navigationBarTrailing) {
                         Button(action: {
                            self.showSheetView = false
                         }) {
                            Text("Done").bold()
                         }
                     }
                 }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
            .accentColor(selectedTheme.themeColor)
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
    
    func checkTypeExists(typeList: [PokemonType], pkmnID: Int, checkType: Int) -> Bool {
        let allTypeList = self.getTypes(typeList: self.pokemonTypeList, pkmnID: pkmnID)
        
        for type1 in allTypeList {
            if type1.type_id == checkType {
                return true
            }
        }
        return false
    }
}
