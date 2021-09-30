//
//  AbilityVoew.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/22/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct AbilityView: View {
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
    
    enum SortType: String, CaseIterable {
        case number, name
    }
    
    enum OrderType: String, CaseIterable {
        case forward, backward
    }
    
    @State private var showSheetView = false
    @State private var searchAbilityText : String = ""
    @State var sorting: SortType
    @State var order: OrderType
    @State var genFilter: Int = 1
    @State var showingGenFilter = false
    @State var showingConquestFilter = false
    @State var inclusiveGenFilter = false
    
    var filteredAbilityList_Gen: [Ability] {
        if showingGenFilter {
            if inclusiveGenFilter {
                return Array(abilityList).filter{$0.generation_id ?? 100 <= self.selectedVersion.versionGen}
            } else {
                return Array(abilityList).filter{$0.generation_id == self.selectedVersion.versionGen}
            }
        } else {
            return Array(abilityList).filter{$0.generation_id ?? 100 <= self.selectedVersion.versionGen}
        }
    }
    
    var filteredAbilityList_Conquest: [Ability] {
        if showingConquestFilter {
            return filteredAbilityList_Gen
        } else {
            return Array(filteredAbilityList_Gen).filter{$0.is_main_series == 1}
        }
    }
    
    var sortedAbilityList: [Ability] {
        switch sorting {
        case .number:
            return filteredAbilityList_Conquest.sorted{$0.id < $1.id}
        case .name:
            return filteredAbilityList_Conquest.sorted{$0.wrappedName < $1.wrappedName}
        }
    }
    
    var orderedAbilityList: [Ability] {
        switch order {
        case .forward:
            return sortedAbilityList
        case .backward:
            return sortedAbilityList.reversed()
        }
    }
    
    var body: some View {
//        NavigationView {
            VStack {
                SearchBar(text: $searchAbilityText)
                    .padding(.horizontal, 4)
                
                List(orderedAbilityList.filter{
                self.searchAbilityText.isEmpty ? true : $0.identifier.contains(self.searchAbilityText) }) { ability in
                    Section {
                        NavigationLink(destination: AbilityDetailView(pokemonList:pokemonList,
                                                                      pokemonFormsList: pokemonFormsList,
                                                                      pokemonTypeList:pokemonTypeList,
                                                                      moveList:moveList,
                                                                      moveEffectList:moveEffectList,
                                                                      typeList:typeList,
                                                                      abilityList:abilityList,
                                                                      abilityProseList:abilityProseList,
                                                                      pokemonAbilitiesList:pokemonAbilitiesList,
                                                                      itemList: itemList, 
                                                                      ability: ability)) {
                            HStack {
                                // Display the ability name
                                Text("\(ability.wrappedName)")
                            }
                        }
                    }
                }
                .id(UUID())
            }
        .navigationBarTitle("Ability List")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.showSheetView.toggle()
                }) {
                    Label("Filter List", systemImage: "arrow.up.arrow.down.circle.fill")
                }
            }
        }
        .sheet( isPresented: self.$showSheetView) {
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
                        
                        Toggle(isOn: self.$showingGenFilter.animation()) {
                            Text("Filter by Generation?")
                        }
                        
                        if self.showingGenFilter {
                            Picker(selection: self.$genFilter, label: EmptyView()) {
                                ForEach(3...7, id: \.self) {
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
                        }
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
    }
}
