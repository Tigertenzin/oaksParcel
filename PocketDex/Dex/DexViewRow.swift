//
//  DexViewRow.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/6/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct DexViewRow: View {
    let pkmn: Pokemon
    let pkmnTypeList: [PokemonType]
    var typeList:  [Type]
    
//    let pokemonSpeciesNameList:  [PokemonSpeciesName] = Bundle.main.decodeCSV("pokemon_species_names.csv")
    
    @EnvironmentObject var selectedVersion: UserVersion
    @EnvironmentObject var selectedTheme: UserTheme
    
    var body: some View {
        HStack {
            // Display the pkmn number
//            Text(String(format: "%03d", pkmn.id))
//                .font(.system(.body, design: .monospaced))
            
            // Display the pkmn sprite
            if selectedTheme.showSprites {
                Image("\(pkmn.imgName)")
            }
            
            // Display the pkmn name
            VStack(alignment: .leading) {
                Text("\(pkmn.wrappedName)")
                    .bold()
                Text(String(format: "%03d", pkmn.id))
                    .font(.system(.caption, design: .monospaced))
            }
//            VStack(alignment: .leading) {
//                Text("\(getSpeciesNames(inputSpecies_id: pkmn.species_id, pokemonSpeciesNameList: pokemonSpeciesNameList)[selectedTheme.displayLanguageID].name ?? pkmn.wrappedName)")
//                Text(String(format: "%03d", pkmn.id))
//                    .font(.system(.caption, design: .monospaced))
//            }
            Spacer()
            
            // Display each of the types (through loop)
            ForEach(pkmnTypeList, id: \.self) { type1 in
                Text("\(self.typeList[type1.type_id - 1].wrappedName)")
                    .frame(width: 56, height: 28)
                    .background(typeColor(type: self.typeList[type1.type_id - 1].wrappedName ))
                    .cornerRadius(6).font(.caption)
            }
        }
    }
}
