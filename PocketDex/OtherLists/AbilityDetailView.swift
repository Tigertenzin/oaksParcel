//
//  AbilityDetailView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/22/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct AbilityDetailView: View {
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
    
    let languageID = 9
    let ability: Ability
    
    @EnvironmentObject var selectedTheme: UserTheme
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: FavPkmn.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \FavPkmn.pkmnID, ascending: true)]) var allFavPkmn: FetchedResults<FavPkmn>
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    HStack{
                        Text("Short Effect")
                            .font(.system(.title2, design: .rounded))
                            .bold()
                            .layoutPriority(1)
                        Spacer()
                    }
                    Text(removeMechanic(input: self.findAbilityProse(abilityID: self.ability.id, languageID: self.languageID, abilityProseList: self.abilityProseList)?.short_effect ?? "N/A"))
                    .lineLimit(10)
                }
                .padding()
                .frame(width: geo.size.width)
                .fixedSize(horizontal: false, vertical: true)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.top, 5)

                VStack(alignment: .leading) {
                    HStack{
                        Text("Full Effect Description")
                            .font(.system(.title2, design: .rounded))
                            .bold()
                            .layoutPriority(1)
                        Spacer()
                    }
                    
                    Text(removeMechanic(input: self.findAbilityProse(abilityID: self.ability.id, languageID: self.languageID, abilityProseList: self.abilityProseList)?.effect ?? "N/A"))
                    .lineLimit(40)
                }
                .padding()
                .frame(width: geo.size.width)
                .fixedSize(horizontal: false, vertical: true)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
                
                VStack {
                    Text("Pokemon that can have the ability: ").font(.caption)
                    ForEach(self.findPokemonWithAbility(abilitytID: self.ability.id, pokemonAbilitiesList: self.pokemonAbilitiesList, pokemonList: self.pokemonList)) { PKMN in
                        NavigationLink(destination: DetailView(pokemonFormsList: pokemonFormsList,
                                                               pokemonTypeList: pokemonTypeList,
                                                               typeList: typeList,
                                                               pokemonList: pokemonList,
                                                               moveList: moveList,
                                                               moveEffectList: moveEffectList,
                                                               abilityList: abilityList,
                                                               abilityProseList: abilityProseList,
                                                               pokemonAbilitiesList: pokemonAbilitiesList,
                                                               itemList: itemList, 
                                                               pkmn: PKMN)) {
                            HStack{
                                if selectedTheme.showSprites {
                                    Image("\(PKMN.imgName)")
                                        .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                                }
                                Text("\(PKMN.id) - \(PKMN.wrappedName)").font(.headline)
                                Spacer()
                                ForEach(self.getTypes(typeList: self.pokemonTypeList, pkmnID: PKMN.id), id: \.self) { type1 in
                                    ZStack {
                                        Text("\(self.typeList[type1.type_id - 1].wrappedName)")
                                            .foregroundColor(Color(UIColor.label))
                                    }
                                        .frame(width: 56, height: 28)
                                        .background(typeColor(type: self.typeList[type1.type_id - 1].wrappedName ))
                                        .cornerRadius(6)
                                        .font(.caption)
                                }
                            }
                            .padding()
                            .frame(width: geo.size.width, height: 48)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(12)
                            .hoverEffect(.highlight)
                        }
                            
                    }
                }
                .padding(.bottom)
                
                
                VStack {
                    Button(action:{
                        if let url = URL(string: self.ability.serebiiURI) {
                        UIApplication.shared.open(url)
                        }
                    }) {
                        Text("Open in Serebii...")
                            .font(.headline)
                    }
                    .padding()
                    .frame(width: geo.size.width)
                    .fixedSize(horizontal: false, vertical: true)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(.bottom)
                    .hoverEffect(.highlight)
                }

            }
        }
        .navigationBarTitle("\(ability.wrappedName)")
        .navigationBarItems(trailing:
            Menu {
                if allFavPkmn.contains{$0.pkmnID == ability.id && $0.type==3} {
                    Button(action: {
//                            let newFavPkmn = FavPkmn(context: self.moc)
//                            newFavPkmn.id = UUID()
//                            newFavPkmn.pkmnID = Int16(pkmn.id)
//                            try? self.moc.save()
                         print("already saved")
                    }) {
                        Text("Added to favorites")
                        Image(systemName: "star.fill")
                    }
                } else {
                    Button(action: {
                        let newFavPkmn = FavPkmn(context: self.moc)
                        newFavPkmn.id = UUID()
                        newFavPkmn.pkmnID = Int16(ability.id)
                        newFavPkmn.type = 3 // Type 2 = Move
                        try? self.moc.save()
                        // print("saved, \(newTeam.name ?? "failed")")
                    }) {
                        Text("Add to favorites")
                        Image(systemName: "star")
                    }
                }
            } label: {
                Image(systemName: "ellipsis.circle")
                    .imageScale(.large)
            }
        )
        .padding(.horizontal)
    }
    
    func findAbilityProse(abilityID: Int, languageID: Int, abilityProseList: [AbilityProse]) -> AbilityProse? {
        
        if let i = abilityProseList.firstIndex(where: {$0.ability_id == abilityID }) {
            if abilityProseList[i].local_language_id == languageID {
                return abilityProseList[i]
            } else if abilityProseList[i+1].local_language_id == languageID {
                return abilityProseList[i+1]
            } else {
                return nil
            }
        }
        return nil
    }
    
    func findPokemonWithAbility(abilitytID: Int, pokemonAbilitiesList: [PokemonAbilities], pokemonList: [Pokemon]) -> [Pokemon] {
        var normalAbilityList = [Pokemon]()
        var hiddenAbilityList = [Pokemon]()
        
        for pkmn in pokemonList[0...806] {
            if let j = pokemonAbilitiesList.firstIndex(where: {$0.pokemon_id == pkmn.id}) { // find the first occurce of the given PKMN
                if pokemonAbilitiesList[j].ability_id == abilitytID { // check if that occurance of the PKMN has the ability in slot 1
                    if pokemonAbilitiesList[j].hidden_bool {
                        hiddenAbilityList.append(pkmn)
                    } else {
                        normalAbilityList.append(pkmn)
                    }
                } else if j < pokemonAbilitiesList.count-1 {
                    if pokemonAbilitiesList[j+1].pokemon_id == pkmn.id {    // check if the next item is also that PKMN,
                        if pokemonAbilitiesList[j+1].ability_id == abilitytID {
                            if pokemonAbilitiesList[j].hidden_bool {
                                hiddenAbilityList.append(pkmn)
                            } else {
                                normalAbilityList.append(pkmn)
                            }
                        }
                    }
                } else if j < pokemonAbilitiesList.count-2 {
                    if pokemonAbilitiesList[j+2].pokemon_id == pkmn.id {    // check if the next item is also that PKMN,
                        if pokemonAbilitiesList[j+1].ability_id == abilitytID {
                            if pokemonAbilitiesList[j].hidden_bool {
                                hiddenAbilityList.append(pkmn)
                            } else {
                                normalAbilityList.append(pkmn)
                            }
                        }
                    }
                }
            }
        }
        return normalAbilityList
    }
    
    func getTypes(typeList: [PokemonType], pkmnID: Int) -> [PokemonType] {
        var resultTypes = [PokemonType]()
        
        if let i = typeList.firstIndex(where: {$0.pokemon_id == pkmnID }) {
            resultTypes.append(typeList[i])
            if typeList[i+1].pokemon_id == pkmnID {
                resultTypes.append(typeList[i+1])
            }
        }
        return resultTypes
    }
}


