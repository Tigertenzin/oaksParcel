//
//  MoveDetailView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/14/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI
import CodableCSV

struct MoveDetailView: View {
    @EnvironmentObject var selectedVersion: UserVersion
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: FavPkmn.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \FavPkmn.pkmnID, ascending: true)]) var allFavPkmn: FetchedResults<FavPkmn>
    
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
    let move: Move
    
    var versionFilter: Int = 18
    
    var pokemonMoveList: [PokemonMove] {
        return Bundle.main.decodeCSV(move.pkmnMovesName + "_\(String(format:"%02d", selectedVersion.versionOrder+1))" + ".csv")
    }
    
    var filteredPokemonMoveList_byVer: [PokemonMove] {
        return pokemonMoveList.filter{$0.version_group_id == self.selectedVersion.versionOrder+1}
    }
    
    var filteredPokemonMoveList: [PokemonMove] {
        return filteredPokemonMoveList_byVer.filter{$0.pokemon_id < 808}
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    HStack{
                        
                        // Move Type
                        HStack{
                            Text("Type")
                                .font(.headline)
                            ZStack {
                                Text("\(self.typeList[self.move.type_id-1].wrappedName)")
                            }
                                .frame(width: 56, height: 28)
                                .background(typeColor(type: self.typeList[self.move.type_id-1].wrappedName))
                                .cornerRadius(6)
                                .font(.caption)
                            
                        }
                        .padding()
                        .frame(width: geo.size.width/2)
                        .fixedSize(horizontal: false, vertical: true)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                        
                        // Move Category
                        HStack{
                            Text("Category")
                                .font(.headline)
                                .fixedSize(horizontal: true, vertical: false)
                            Text("\(self.move.damage_class)")
                                .frame(width: 56, height: 28)
                                .background(self.categoryColor(category: self.move.damage_class))
                                .cornerRadius(6)
                                .font(.caption)
                        }
                        .padding()
                        .frame(width: geo.size.width/2)
                        .fixedSize(horizontal: false, vertical: true)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                    }
                    .padding(.top)
                    
                    VStack(alignment: .leading) {
                        HStack{
                            Text("Move Details")
                                .font(.system(.title2, design: .rounded))
                                .bold()
                            Spacer()
                        }
                        
                        Divider()
                        
                        HStack{
                            Text("Power:")
                                .font(.headline)
                            Text("\(self.move.wrappedPower)")
                        }
                        
                        HStack{
                            Text("Accuracy:")
                                .font(.headline)
                            Text("\(self.move.wrappedAccuracy)")
                        }
                        
                        HStack{
                            Text("PP:")
                                .font(.headline)
                            Text("\(self.move.wrappedPP)")
                        }
                    }
                    .padding()
                    .frame(width: geo.size.width)
                    .fixedSize(horizontal: false, vertical: true)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    
                    // Move Battle Effect
                    VStack(alignment: .leading) {
                        HStack{
                            Text("Battle Effect")
                                .font(.system(.title2, design: .rounded))
                                .bold()
                            Spacer() 
                        }
                        Text(self.moveEffectFromId(moveEffectID: self.move.effect_id, effectChance: self.move.effect_chance, moveEffectList: moveEffectList))
                            .lineLimit(40)
                    }
                    .padding()
                    .frame(width: geo.size.width)
                    .fixedSize(horizontal: false, vertical: true)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    
                    // Pokemon that can learn the move
                    VStack{
                        Text("Pokemon than can learn the move: ")
                            .font(.caption)
                        
                        ForEach(self.filteredPokemonMoveList, id: \.id) { pokemonMove in
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
                                                                   pkmn: self.pokemonList[pokemonMove.pokemon_id-1])) {
                                pokemonRow(PKMN: self.pokemonList[pokemonMove.pokemon_id-1], pokemonMove: pokemonMove)
                                    .padding()
                                    .frame(width: geo.size.width, height: 48)
                                    .background(Color(UIColor.secondarySystemBackground))
                                    .cornerRadius(12)
                                    .hoverEffect(.highlight)
                            }
                        }
                    }
                    
                }
            }
            
            .navigationBarTitle("\(self.move.wrappedName)", displayMode: .inline)
            .navigationBarItems(trailing:
                Menu {
                    if allFavPkmn.contains{$0.pkmnID == move.id && $0.type==2} {
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
                            newFavPkmn.pkmnID = Int16(move.id)
                            newFavPkmn.type = 2 // Type 2 = Move
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
        }
        .padding(.horizontal)
    }
    
    func moveEffectFromId(moveEffectID: Int, effectChance: Int?, moveEffectList: [MoveEffectProse]) -> String {
        var uncleanMoveEffect = ""
        
        if let i = moveEffectList.firstIndex(where: {$0.move_effect_id == moveEffectID }) {
            uncleanMoveEffect = moveEffectList[i].short_effect?.replacingOccurrences(of: "$effect_chance", with: "\(effectChance ?? 0)") ?? "No Effect"
            return removeMechanic(input: uncleanMoveEffect)
        }
        return "No Effect"
        
    }
    
    func categoryColor(category: String) -> Color {
        if category == "Physical" {
            return Color.red
        } else if category == "Special" {
            return Color.blue
        } else if category == "Status" {
            return Color.gray
        } else {
            return Color.white
        }
    }
}

struct pokemonRow: View {
    let PKMN: Pokemon
    let pokemonMove: PokemonMove
    var typeList:  [Type] = Bundle.main.decode("types.json")
    var pokemonTypeList:  [PokemonType] = Bundle.main.decode("pokemon_types.json")
    
    @EnvironmentObject var selectedTheme: UserTheme
    
    let moveMethod: [String] = ["Level-up", "Egg Move", "Move Tutor", "TM/HM", "Stadium Surfing Pikachu", "Light Ball Egg Move", "Colosseum Purification", "XD-Shadow", "XD-Prufication", "Form Change"]
    
    var body: some View {
        HStack{
            if selectedTheme.showSprites {
                Image("\(PKMN.imgName)")
                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
            }
            VStack(alignment: .leading) {
                Text("\(PKMN.id) - \(PKMN.wrappedName)")
                    .font(.headline)
                Text("\(moveMethod[pokemonMove.pokemon_move_method_id-1])")
                    .font(.caption)
            }
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
