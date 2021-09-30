//
//  DetailEvoView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/18/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct DetailEvoView: View {
    @Binding var pkmn: Pokemon
    
    var pokemonFormsList: [Pokemon_Forms]
    var pokemonTypeList:  [PokemonType]
    var typeList:  [Type]
    var pokemonList:  [Pokemon]
    var moveList:  [Move]
    var moveEffectList:  [MoveEffectProse]
    var abilityList:  [Ability]
    var abilityProseList:  [AbilityProse]
    var pokemonAbilitiesList:  [PokemonAbilities]
    var itemList: [Item]
    @Binding var showingEvols: Bool
    
    var body: some View {
        VStack{
            HStack{
               Text("Evolution Chain")
                .font(.system(.title2, design: .rounded))
                .bold()
                .multilineTextAlignment(.leading)
                Spacer()
                Button(action: {
                    self.showingEvols.toggle()
                }) {
                    if self.showingEvols {
                        Image(systemName: "chevron.down.circle").imageScale(.large)
                    }
                    if self.showingEvols==false {
                        Image(systemName: "chevron.left.circle").imageScale(.large)
                    }
                }.hoverEffect()
            }
            if self.showingEvols {
                evoView(pkmn: self.$pkmn,
                        evoLine: self.sortEvoChain(evoChain: self.evolutionChainFromID(speciesID: pkmn.id)),
                        pokemonFormsList: pokemonFormsList,
                        pokemonTypeList: pokemonTypeList,
                        typeList: typeList,
                        pokemonList: pokemonList,
                        moveList: moveList,
                        moveEffectList: moveEffectList,
                        abilityList: abilityList,
                        abilityProseList: abilityProseList,
                        pokemonAbilitiesList: pokemonAbilitiesList,
                        itemList: itemList)
            }
        }
    }
    
    func evolutionChainFromID(speciesID: Int) -> [PokemonSpecies] {
        let pokemonSpeciesList: [PokemonSpecies] = Bundle.main.decode("pokemon_species.json")
        var result = [PokemonSpecies]()
        var evoChainID = 1
        
        if let j = pokemonSpeciesList.firstIndex(where: {$0.id == speciesID }) {
            evoChainID = pokemonSpeciesList[j].evolution_chain_id
            
            for pkmn in pokemonSpeciesList {
                if pkmn.evolution_chain_id == evoChainID {
                    result.append(pkmn)
                }
            }
        }
        return result
    }
    
    func sortEvoChain(evoChain: [PokemonSpecies]) -> [PokemonSpecies] {
        var result = [PokemonSpecies]()
        var nextStages = [PokemonSpecies]()
        var tempFrom: Int = 0
        
        if let i = evoChain.firstIndex(where: {$0.evolves_from_species_id == nil }) {
            result.append(evoChain[i])
            tempFrom = evoChain[i].id
            
            for pkmn in evoChain {
                if pkmn.evolves_from_species_id == tempFrom {
                    nextStages.append(pkmn)
                }
            }
            result.append(contentsOf: nextStages)
            
            for tempPkmn in nextStages {
                for pkmn in evoChain {
                    if pkmn.evolves_from_species_id == tempPkmn.id {
                        result.append(pkmn)
                    }
                }
            }
        }
        return result
    }
}


struct evoView: View {
    @Binding var pkmn: Pokemon
    let evoLine: [PokemonSpecies]
    
    var pokemonEvolList: [Pokemon_Evol] = Bundle.main.decodeCSV("pokemon_evolution.csv")
    var pokemonFormsList: [Pokemon_Forms]
    var pokemonTypeList:  [PokemonType]
    var typeList:  [Type]
    var pokemonList:  [Pokemon]
    var moveList:  [Move]
    var moveEffectList:  [MoveEffectProse]
    var abilityList:  [Ability]
    var abilityProseList:  [AbilityProse]
    var pokemonAbilitiesList:  [PokemonAbilities]
    var itemList: [Item]
    @EnvironmentObject var selectedTheme: UserTheme
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top) {
                ForEach(evoLine) { pkmnSpecies in
                    Button(action: {
                        self.pkmn = pokemonList[pkmnSpecies.id-1]
                    }) {
                        VStack {
                            if selectedTheme.showSprites {
                                Image("\(pkmnSpecies.imgName)")
                                    .interpolation(.none)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 64, height: 64)
                            }
                            Text("\(pkmnSpecies.wrappedName)")
                                .font(.system(.footnote, design: .rounded))
                                .bold()
                                .fixedSize(horizontal: true, vertical: true)
                                .padding(.horizontal)
                                .frame(height: 24)
                            Text(getEvoDets(pkmnPost: pkmnSpecies, pokemonList: pokemonList, moveList: moveList, itemList: itemList) ?? "")
                                .font(.caption)
                                .padding(.horizontal)
                                .fixedSize(horizontal: true, vertical: true)
                                .lineLimit(40)
                                .padding(.bottom)
                        }
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(8)
                    }
                    .hoverEffect()
//                    NavigationLink(destination: DetailView(pokemonFormsList: pokemonFormsList,
//                                                           pokemonTypeList: pokemonTypeList,
//                                                           typeList: typeList,
//                                                           pokemonList: pokemonList,
//                                                           moveList: moveList,
//                                                           moveEffectList: moveEffectList,
//                                                           abilityList: abilityList,
//                                                           abilityProseList: abilityProseList,
//                                                           pokemonAbilitiesList: pokemonAbilitiesList,
//                                                           itemList: itemList,
//                                                           otherForms: getOtherForms(inputPokemon: pokemonList[pkmnSpecies.id-1], pokemonList: pokemonList),
//                                                           pkmn: pokemonList[pkmnSpecies.id-1])) {
//                        VStack {
//                            if selectedTheme.showSprites {
//                                Image("\(pkmnSpecies.imgName)")
//                                    .interpolation(.none)
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 64, height: 64)
//                            }
//                            Text("\(pkmnSpecies.wrappedName)")
//                                .font(.system(.footnote, design: .rounded))
//                                .bold()
//                                .fixedSize(horizontal: true, vertical: true)
//                                .padding(.horizontal)
//                                .frame(height: 24)
//                            Text(getEvoDets(pkmnPost: pkmnSpecies, pokemonList: pokemonList, moveList: moveList, itemList: itemList) ?? "")
//                                .font(.caption)
//                                .padding(.horizontal)
//                                .fixedSize(horizontal: true, vertical: true)
//                                .lineLimit(40)
//                                .padding(.bottom)
//                        }
//                        .background(Color(UIColor.tertiarySystemFill))
//                        .cornerRadius(8)
//                    }
//                    .hoverEffect()
                }
            }
        }
    }
    
    func getEvoDets(pkmnPost: PokemonSpecies, pokemonList: [Pokemon], moveList: [Move], itemList: [Item]) -> String? {
        var evolutionString = ""
        if let j = pokemonEvolList.firstIndex(where: {$0.evolved_species_id == pkmnPost.id}) {
            if pokemonEvolList[j].evolution_trigger_id==1 { //level-up
                evolutionString = "Level "
                
                if pokemonEvolList[j].minimum_level != nil {
                    evolutionString += String(pokemonEvolList[j].minimum_level ?? 0)
                } else {
                    evolutionString += "up"
                }
                
                if pokemonEvolList[j].gender_id == 1 {
                    evolutionString += " (f)"
                } else if pokemonEvolList[j].gender_id == 2 {
                    evolutionString += " (m)"
                }
                
                if pokemonEvolList[j].location_id != nil {
                    evolutionString += "\nat Loc: \(pokemonEvolList[j].location_id ?? 1)"
                }
                
                if pokemonEvolList[j].held_item_id != nil {
                    evolutionString += "\nholding \(itemList[(pokemonEvolList[j].held_item_id ?? 1)-1].wrappedName)"
                }
                
                if pokemonEvolList[j].time_of_day != nil {
                    evolutionString += "\nDuring: \(pokemonEvolList[j].time_of_day ?? "anytime")"
                }
                
                if pokemonEvolList[j].known_move_id != nil {
                    evolutionString += "\nWhile knowing \(moveList[(pokemonEvolList[j].known_move_id ?? 1) - 1].wrappedName)"
                }
                
                if pokemonEvolList[j].minimum_happiness != nil {
                    evolutionString += "\nWith max happiness"
                }
                
                if pokemonEvolList[j].minumum_beauty != nil {
                    evolutionString += "\nWith max beauty"
                }
                
                if pokemonEvolList[j].relative_physical_stats == 1 {
                    evolutionString += "\nWith Atk > Def"
                } else if pokemonEvolList[j].relative_physical_stats == -1 {
                    evolutionString += "\nWith Atk < Def"
                } else if pokemonEvolList[j].relative_physical_stats == 0 {
                    evolutionString += "\nWith Atk = Def"
                }
                
                if pokemonEvolList[j].party_species_id != nil {
                    evolutionString += "\nWith \(pokemonList[(pokemonEvolList[j].party_species_id ?? 1) - 1].wrappedName) in party"
                }
            } else if pokemonEvolList[j].evolution_trigger_id==2 {
                evolutionString = "Trade"
                if pokemonEvolList[j].held_item_id != nil {
                    evolutionString += "\nholding \(itemList[(pokemonEvolList[j].held_item_id ?? 1)-1].wrappedName)"
                }
                
                if pokemonEvolList[j].trade_species_id != nil {
                    evolutionString += "\nfor \(pokemonList[(pokemonEvolList[j].trade_species_id ?? 1) - 1].wrappedName)"
                }
            } else if pokemonEvolList[j].evolution_trigger_id==3 {
                evolutionString = "Use "
                if pokemonEvolList[j].trigger_item_id != nil {
                    evolutionString += "\(itemList[(pokemonEvolList[j].trigger_item_id ?? 1)-1].wrappedName)"
                }
                if pokemonEvolList[j].gender_id == 1 {
                    evolutionString += "\n(female)"
                } else if pokemonEvolList[j].gender_id == 2 {
                    evolutionString += "\n(male)"
                }
            }
            
            return evolutionString
        } else {
            return nil
        }
    }
}
