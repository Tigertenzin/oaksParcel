//
//  AddPokemonToTeamView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/24/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct AddPokemonToTeamView: View {
    @Binding var pkmn1: Pokemon
    @Binding var searchText: String
    @Binding var versionOrderID: Int
    
    var body: some View {
        Picker("Pokemon 1: ", selection: $pkmn1) {
            SearchBar(text: $searchText)
            ForEach(validPokemonList.filter{
            self.searchText.isEmpty ? true : $0.identifier.contains(self.searchText) }, id: \.self) {
                
                    Text("\($0.id) - \($0.wrappedName)")
                
            }
        }
    }
}

struct AddPokemonToTeamView_Previews: PreviewProvider {
    static var previews: some View {
        AddPokemonToTeamView()
    }
}
