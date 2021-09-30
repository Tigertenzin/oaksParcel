//
//  LocationEncounterRow.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/26/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct LocationEncounterRows: View {
    
    var selectedVersionID: Int
    var locationAreaID: Int
    var relevantEncounters: [Encounters]
    var encounterSlotList: [EncountersSlot]
    var pokemonList: [Pokemon]
    
    var filteredRelevantEncounters: [Encounters] {
        return relevantEncounters.filter{$0.location_area_id == locationAreaID}
    }
    
    var sortedRelevantEncounters: [Encounters] {
        return filteredRelevantEncounters.sorted{
            (encounterSlotList[$0.encounter_slot_id-1].encounter_method_id, $0.pokemon_id ?? 1, encounterSlotList[$0.encounter_slot_id-1].rarity) < (encounterSlotList[$1.encounter_slot_id-1].encounter_method_id, $1.pokemon_id ?? 2, encounterSlotList[$1.encounter_slot_id-1].rarity) }
    }
    
    var encounterMethodList = ["Walk", "Old-Rod", "Good-Rod", "Super-Rod", "Surf", "Rock Smash", "Headbutt", "Dark Grass", "Grass Spots", "Cave Spots", "Bridge Spots", "Super-Rod Spots", "Surf Spots", "Yellow Flowers", "Purple Flowers", "Red Flowers", "Rough Terrain", "Gift", "Gift Egg"]
    
//    let columns = [
//        GridItem(.flexible()),
//        GridItem(.flexible()),
//        GridItem(.flexible()),
//        GridItem(.flexible())
//    ]
    
    var body: some View {
        
        VStack(alignment: .leading)  {
            ForEach(sortedRelevantEncounters, id: \.self) { encounter in
                if encounter.location_area_id == locationAreaID && encounter.version_id == selectedVersionID {
                    
                    HStack{
                        HStack{
                            Image("\(encounter.pokemon_id ?? 1)")
                            Text("\(pokemonList[(encounter.pokemon_id ?? 1)-1].wrappedName)")
                                .font(.caption)
                                .fixedSize(horizontal: true, vertical: false)
                        }
                        .padding(10)
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(8)
                        .hoverEffect()
                        
                        Spacer()
                            
                        Text("\(encounterSlotList[encounter.encounter_slot_id-1].rarity)%")
                        
                        Spacer()
                        
                        if encounter.min_level == encounter.max_level{
                            Text("Lv \(encounter.min_level ?? 1)")
                                .fixedSize(horizontal: true, vertical: false)
                        } else {
                            Text("Lv \(encounter.min_level ?? 1)-\(encounter.max_level ?? 100)")
                                .fixedSize(horizontal: true, vertical: false)
                        }
                        
                        Spacer()
                        
                        Text("\(encounterMethodList[encounterSlotList[encounter.encounter_slot_id-1].encounter_method_id-1])")
                            .fixedSize(horizontal: true, vertical: false)
                            .padding(.horizontal, 4)
                        
                    }
                    
                    Divider()
                    
                }
            }
        }
    }
}

