//
//  LocationDetailView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/23/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct LocationDetailView: View {
    var pokemonList: [Pokemon]
    var locationList:  [Location]
    var locationAreasList: [Location_Areas]
    var encountersList: [Encounters]
    var encounterSlotList: [EncountersSlot]
    
    var location: Location
    
    @State var selectedEncounterVersion = 1
    @State var selectedAreaVersion = 0
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var relevantLocAreas: [Location_Areas] {
        return findLocAreas(input_location_id: location.id, locationAreasList: locationAreasList)
    }
    
    let regionList = ["Other", "Kanto", "Johto", "Hoenn", "Sinnoh", "Unova", "Kalos", "Alola"]
    let versionList = ["Red","Blue","Yellow","Gold","Silver","Crystal","Ruby","Sapphire","Emerald","Firered","Leafgreen","Diamond","Pearl","Platinum","Heartgold","Soulsilver","Black","White","Colosseum","XD","Black 2","White 2","X","Y","Omega Ruby","Alpha Sapphire","Sun","Moon","Ultra Sun","Ultra Moon"]
    
    @EnvironmentObject var selectedTheme: UserTheme
    @EnvironmentObject var selectedVersion: UserVersion
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    HStack{
                        Text("Region")
                            .font(.system(.title2, design: .rounded))
                            .bold()
                            .layoutPriority(1)
                        Spacer()
                        Text("\(regionList[location.region_id ?? 0])")
                    }
                }
                .padding()
                .frame(width: geo.size.width)
                .fixedSize(horizontal: false, vertical: true)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.top, 5)
                
                if relevantLocAreas.count > 1 {
                    VStack(alignment: .leading) {
                        HStack{
                            Text("Areas")
                                .font(.system(.title2, design: .rounded))
                                .bold()
                                .layoutPriority(1)
                            Spacer()
                        }
                        HStack{
                            Text("Select area to display")
                                .font(.caption)
                            Spacer()
                        }
                        LazyVGrid(columns: columns, spacing: 2) {
                            ForEach(0..<relevantLocAreas.count, id: \.self) { locAreaNo in
                                
                                Button(action: {
                                    self.selectedAreaVersion = locAreaNo
                                }) {
                                    Text(relevantLocAreas[locAreaNo].wrappedName ?? "N/A")
                                        .font(.caption)
                                }
                                .padding(8)
                                .fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(locAreaNo == selectedAreaVersion ? Color(UIColor.label) : selectedTheme.themeColor)
                                .background(locAreaNo == selectedAreaVersion ? selectedTheme.themeColor : Color(UIColor.systemGray5))
                                .cornerRadius(8)
                                .hoverEffect()
                                .frame(width: 100, height: 36)
                            }
                        }
                        
//                        HStack{
//                            ScrollView(.horizontal) {
//                                ForEach(relevantLocAreas, id: \.id) { locArea in
//                                    Text(locArea.wrappedName ?? "N/A")
//                                }
//                            }
//                        }
                    }
                    .padding()
                    .frame(width: geo.size.width)
                    .fixedSize(horizontal: false, vertical: true)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(.top, 5)
                }
                
                // Select version by contacts-like buttons
                if findVersion(inputAreasList: relevantLocAreas, encountersList: encountersList).count > 0 {
                    VStack{
                        HStack{
                            Text("Versions")
                                .font(.system(.title2, design: .rounded))
                                .bold()
                                .layoutPriority(1)
                            Spacer()
                        }
                        HStack{
                            Text("Select version to display")
                                .font(.caption)
                            Spacer()
                        }
                        
                        LazyVGrid(columns: columns, spacing: 2) {
                            ForEach(findVersion(inputAreasList: relevantLocAreas, encountersList: encountersList), id: \.self) { possibleVersion in
                                
                                Button(action: {
                                    self.selectedEncounterVersion = possibleVersion
                                }) {
                                    Text("\(versionList[possibleVersion-1])")
                                        .font(.footnote)
                                }
                                .padding(8)
                                .fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(possibleVersion == selectedEncounterVersion ? Color(UIColor.label) : selectedTheme.themeColor)
                                .background(possibleVersion == selectedEncounterVersion ? selectedTheme.themeColor : Color(UIColor.systemGray5))
                                .cornerRadius(8)
                                .hoverEffect()
                                .frame(width: 100, height: 36)
                            }
                        }
                    }
                    .padding()
                    .frame(width: geo.size.width)
                    .fixedSize(horizontal: false, vertical: true)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    .animation(.default)
                }
                
                
                // show encounters data
                VStack(alignment: .leading) {
                    HStack{
                        Text("Encounters - \(relevantLocAreas[selectedAreaVersion].wrappedName ?? "Main Area")")
                            .font(.system(.title2, design: .rounded))
                            .bold()
                            .layoutPriority(1)
                        Spacer()
                    }
                    .padding(.bottom, 4)
                    LocationEncounterRows(selectedVersionID: self.selectedEncounterVersion, locationAreaID: relevantLocAreas[selectedAreaVersion].id, relevantEncounters: findEncounters(inputAreasList: relevantLocAreas, encountersList: encountersList), encounterSlotList: self.encounterSlotList, pokemonList: self.pokemonList)
                    
//                    ForEach(relevantLocAreas, id: \.self) { locArea in
//
//                        VStack {
//                            HStack{
//                                Text("Area - \(locArea.wrappedName ?? "Main Area")")
//                                    .font(.system(.title3, design: .rounded))
//                                    .bold()
//                                    .layoutPriority(1)
//                                Spacer()
//                            }
//
//                            LocationEncounterRows(selectedVersionID: self.selectedEncounterVersion, locationAreaID: locArea.id, relevantEncounters: findEncounters(inputAreasList: relevantLocAreas, encountersList: encountersList), encounterSlotList: self.encounterSlotList, pokemonList: self.pokemonList)
//                        }
//                    }
                    
                }
                .padding()
                .frame(width: geo.size.width)
                .fixedSize(horizontal: false, vertical: true)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.top, 5)

                
            }
            .navigationBarTitle(location.wrappedName)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        ForEach(findVersion(inputAreasList: relevantLocAreas, encountersList: encountersList), id: \.self) { possibleVersion in
                            Button(action: {
                                self.selectedEncounterVersion = possibleVersion
                            }) {
                                Text("See version \(possibleVersion)")
                            }
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .imageScale(.large)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    func findLocAreas(input_location_id: Int, locationAreasList: [Location_Areas]) -> [Location_Areas] {
        var relevantLocAreas = [Location_Areas]()
        
        if let i = locationAreasList.firstIndex(where: {$0.location_id == input_location_id}) {
            for locArea in locationAreasList[i..<locationAreasList.count] {
                if locArea.location_id==input_location_id {
                    relevantLocAreas.append(locArea)
                } else {
                    break
                }
            }
        }
        return relevantLocAreas
    }
    
    func findEncounters(inputAreasList: [Location_Areas], encountersList: [Encounters]) -> [Encounters] {
        var relevantEncounters = [Encounters]()
        
        for encounter in encountersList {
            if inputAreasList.contains(where: { $0.id == encounter.location_area_id}) {
                relevantEncounters.append(encounter)
            }
        }
        return relevantEncounters
    }
    
    func findVersion(inputAreasList: [Location_Areas], encountersList: [Encounters]) -> [Int] {
        let relevantEncounters = findEncounters(inputAreasList: inputAreasList, encountersList: encountersList)
        
        var relevantVersionList = [Int]()
        for j in 1...30 {
            if relevantVersionList.contains(j) {
                print("already found")
            } else {
                if relevantEncounters.contains(where: {$0.version_id == j}) {
                    relevantVersionList.append(j)
                }
            }
        }
        print(relevantVersionList)
        return relevantVersionList
    }
}
