//
//  MovesView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/13/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI
import CodableCSV

struct MovesView: View {
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
        case number, name, power
    }
    
    enum OrderType: String, CaseIterable {
        case forward, backward
    }
    
    @State private var showSheetView = false
    @State private var searchMoveText : String = ""
    @State var sorting: SortType
    @State var order: OrderType
    @State var typeFilter: Int = 1
    @State var genFilter: Int = 1
    @State var showingTypeFilter = false
    @State var showingGenFilter = false
    @State var inclusiveGenFilter = false
    
    var filteredMoveList_Type: [Move] {
        if showingTypeFilter {
            return Array(moveList).filter{$0.type_id == self.typeFilter}
        } else {
            return moveList
        }
    }
    
    var filteredMoveList_Gen: [Move] {
        if showingGenFilter {
            if inclusiveGenFilter {
                return Array(filteredMoveList_Type).filter{$0.generation_id <= self.genFilter}
            } else {
                return Array(filteredMoveList_Type).filter{$0.generation_id == self.genFilter}
            }
        } else {
            return Array(filteredMoveList_Type).filter{$0.generation_id <= self.selectedVersion.versionGen}
        }
    }
    
    var sortedMoveList: [Move] {
        switch sorting {
        case .number:
            return filteredMoveList_Gen.sorted{$0.id < $1.id}
        case .name:
            return filteredMoveList_Gen.sorted{$0.wrappedName < $1.wrappedName}
        case .power:
            return filteredMoveList_Gen.sorted{$0.sortPower < $1.sortPower}
        }
    }
    
    var orderedMoveList: [Move] {
        switch order {
        case .forward:
            return sortedMoveList
        case .backward:
            return sortedMoveList.reversed()
        }
    }
    
    var body: some View {
//        NavigationView {
            VStack {
                SearchBar(text: $searchMoveText)
                    .padding(.horizontal, 4)
                
                List(orderedMoveList.filter{
                self.searchMoveText.isEmpty ? true : $0.identifier.contains(self.searchMoveText) }) { move in
                    Section {
                        NavigationLink(destination: MoveDetailView(pokemonList: pokemonList,
                                                                   pokemonFormsList: pokemonFormsList,
                                                                   pokemonTypeList: pokemonTypeList,
                                                                   moveList: moveList,
                                                                   moveEffectList: moveEffectList,
                                                                   typeList: typeList,
                                                                   abilityList: abilityList,
                                                                   abilityProseList: abilityProseList, 
                                                                   pokemonAbilitiesList: pokemonAbilitiesList,
                                                                   itemList: itemList, 
                                                                   move: move)) {
                            HStack {
                                // Display the pkmn sprite
                                Text("\(move.wrappedName)")
                                
                                Spacer()

                                // Display the move's type
                                ZStack {
                                    Text("\(self.typeList[move.type_id-1].wrappedName)")
                                }.frame(width: 56, height: 28).background(typeColor(type: self.typeList[move.type_id-1].wrappedName)).cornerRadius(6).font(.caption)
                            }
                        }
                    }
                }
                .id(UUID())
            }
            .navigationBarTitle("Move List")
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
            filterSheet
        }
    }
    
    var filterSheet: some View {
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
                
                Section(header: Text("Filters")) {
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
