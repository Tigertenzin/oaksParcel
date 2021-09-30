//
//  LocationsView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/23/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct LocationsView: View {
    var pokemonList: [Pokemon]
    var locationList:  [Location]
    var locationAreasList:  [Location_Areas]
    var encountersList: [Encounters]
    var encounterSlotList: [EncountersSlot]
    
    @State private var searchText = ""
    @State private var showingFilterScreen = false
    
    @State private var filterByRegion = false
    @State private var regionFilter = 0
    let regionList = ["Kanto", "Johto", "Hoenn", "Sinnoh", "Unova", "Kalos", "Alola"]
    
    
    @EnvironmentObject var selectedTheme: UserTheme
    @EnvironmentObject var selectedVersion: UserVersion
    
    
    var sortedLocationList: [Location] {
        var tempList = [Location]()
        
        if filterByRegion {
            tempList = locationList.filter{$0.region_id == regionFilter+1}
        } else {
            tempList = locationList
        }
        return tempList.sorted{($0.region_id ?? 10, $0.identifier) < ($1.region_id ?? 10, $1.identifier)}
    }
    
    
    var body: some View {
        VStack{
            SearchBar(text: $searchText)
                .padding(.horizontal, 4)
            List {
                
                ForEach(sortedLocationList.filter{self.searchText.isEmpty ? true : $0.identifier.contains(self.searchText) }, id: \.id) { location in
                    NavigationLink(destination: LocationDetailView(pokemonList: pokemonList,
                                                                   locationList: locationList,
                                                                   locationAreasList: locationAreasList,
                                                                   encountersList: encountersList,
                                                                   encounterSlotList: encounterSlotList,
                                                                   location: location)) {
                        VStack(alignment: .leading) {
                            Text(location.wrappedName)
                            Text(location.regionName)
                                .font(.footnote)
                        }
                    }
                }
            }
            .id(UUID())
        }
        .navigationBarTitle("Locations")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.showingFilterScreen = true
                }) {
                    Label("Filter List", systemImage: "arrow.up.arrow.down.circle.fill")
                }
            }
        }
        .sheet(isPresented: self.$showingFilterScreen) {
            NavigationView {
                Form {
                    
                    Toggle(isOn: self.$filterByRegion.animation()) {
                        Text("Filter by Region?")
                    }
                    
                    if filterByRegion {
                        Picker(selection: self.$regionFilter, label: EmptyView()) {
                            ForEach(0..<7, id: \.self) {
                                Text(regionList[$0])
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                }
                .navigationBarTitle("Filters", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    self.showingFilterScreen = false
                    }) {
                    Text("Done").bold()
                    })
            }
        }
    }
}
