//
//  DetailAbilityView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/18/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct DetailAbilityView: View {
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
    let pkmnID: Int
    @Binding var showingAbilities: Bool
    
    var body: some View {
        VStack{
            HStack{
                Text("Abilities")
                    .font(.system(.title2, design: .rounded))
                    .bold()
                    .multilineTextAlignment(.leading)
                Spacer()
                Button(action: {
                    self.showingAbilities.toggle()
                }) {
                    if self.showingAbilities {
                        Image(systemName: "chevron.down.circle")
                            .imageScale(.large)
                    }
                    if self.showingAbilities==false {
                        Image(systemName: "chevron.left.circle")
                            .imageScale(.large)
                    }
                }.hoverEffect(.lift)
            }
            
            if self.showingAbilities {
                ForEach(self.getAbilities(pkmnID: pkmnID)) { ability in
                    VStack{
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
                                                                      ability: self.findAbility(abilityID: ability.ability_id, abilityList: abilityList))) {
                            VStack{
                                Divider()
                                HStack{
                                    Text("\(self.findAbility(abilityID: ability.ability_id, abilityList: abilityList).wrappedName): ")
                                        .fontWeight(.bold)
                                        .hoverEffect(.highlight)
                                    if ability.is_hidden == 1 {
                                        Text("(hidden ability)")
                                    }
                                    
                                    Spacer()
                                    
                                }
                                HStack{
                                    Text(removeMechanic(input: self.findAbilityProse(abilityID: ability.ability_id, languageID: 9, abilityProseList: abilityProseList).short_effect))
//                                        .frame(width: geo.size.width*0.95)
                                        .padding(5)
                                        .lineLimit(40)
                                        .fixedSize(horizontal: false, vertical: true)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                }
                            }
                        }
//                        .padding()
                        .cornerRadius(8)
                        .hoverEffect()
                    }
                }
            }
        }
    }
    
    func getAbilities(pkmnID: Int) -> [PokemonAbilities] {
        var finalList = [PokemonAbilities]()
        
        if let j = pokemonAbilitiesList.firstIndex(where: {$0.pokemon_id == pkmnID}) {
            finalList.append(pokemonAbilitiesList[j])
            if pokemonAbilitiesList[j+1].pokemon_id == pkmnID {
                finalList.append(pokemonAbilitiesList[j+1])
            }
            if pokemonAbilitiesList[j+2].pokemon_id == pkmnID {
                finalList.append(pokemonAbilitiesList[j+2])
            }
        }
        
        return finalList
    }
    
    func findAbilityProse(abilityID: Int, languageID: Int, abilityProseList: [AbilityProse]) -> AbilityProse {
        if let i = abilityProseList.firstIndex(where: {$0.ability_id == abilityID }) {
            if abilityProseList[i].local_language_id == languageID {
                return abilityProseList[i]
            } else if abilityProseList[i+1].local_language_id == languageID {
                return abilityProseList[i+1]
            } else {
                return AbilityProse()
            }
        }
        return AbilityProse()
    }
    
    func findAbility(abilityID: Int, abilityList: [Ability]) -> Ability {
        if let i = abilityList.firstIndex(where: {$0.id == abilityID }) {
            return abilityList[i]
        }
        return Ability()
    }
}

//struct DetailAbilityView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailAbilityView()
//    }
//}
