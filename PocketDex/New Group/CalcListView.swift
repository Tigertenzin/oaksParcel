//
//  CalcListView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/28/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct CalcListView: View {
    
    var pokemonList:  [Pokemon]
    var pokemonFormsList: [Pokemon_Forms]
    var pokemonTypeList:  [PokemonType]
    var pokemonStatList: [PokemonStat]
    var moveList:  [Move]
    var moveEffectList:  [MoveEffectProse]
    var typeList:  [Type]
    var abilityList:  [Ability]
    var abilityProseList:  [AbilityProse]
    var pokemonAbilitiesList:  [PokemonAbilities]
    var itemList:  [Item]
    var itemProseList:  [ItemProse]
    
    var body: some View {
        List {
                        
            NavigationLink(destination: DamageCalcView(pokemonList: pokemonList,
                                                       pokemonTypeList: pokemonTypeList,
                                                       pokemonStatList: pokemonStatList,
                                                       moveList: moveList,
                                                       moveEffectList: moveEffectList,
                                                       typeList: typeList,
                                                       abilityList: abilityList,
                                                       abilityProseList: abilityProseList,
                                                       pokemonAbilitiesList: pokemonAbilitiesList,
                                                       itemList: itemList,
                                                       itemProseList: itemProseList)) {
                Text("Damage Calculator")
            }
            
            NavigationLink(destination: TypeMatchupView(typeList: typeList)) {
                Text("Type Matchups")
            }
            
            NavigationLink(destination: CompareView(pokemonFormsList: self.pokemonFormsList,
                                                    pokemonTypeList: self.pokemonTypeList,
                                                    typeList: self.typeList,
                                                    pokemonList: self.pokemonList,
                                                    moveList: self.moveList,
                                                    moveEffectList: self.moveEffectList,
                                                    abilityList: self.abilityList,
                                                    abilityProseList: self.abilityProseList,
                                                    pokemonAbilitiesList: self.pokemonAbilitiesList,
                                                    itemList: self.itemList,
                                                    pokemonStatList: self.pokemonStatList)) {
                Text("Stat Compare")
            }
            
//            NavigationLink(destination: ExpStatCalcView()) {
//                Text("Experience Calculator")
//            }
        }
        .navigationBarTitle("Calculators")
        .listStyle(InsetGroupedListStyle())
    }
}
