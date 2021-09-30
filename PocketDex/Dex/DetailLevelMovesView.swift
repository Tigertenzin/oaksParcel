//
//  DetailLevelMovesView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/18/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct DetailLevelMovesView: View {
    @EnvironmentObject var selectedVersion: UserVersion
    
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
    let pokemonMoveList: [PokemonMove]
    @Binding var showingMoves: Bool
    
    var versionFilter: Int {
        return selectedVersion.versionOrder
    }
    var filteredPokemonMoveList: [PokemonMove] {
        return pokemonMoveList.filter{$0.pokemon_move_method_id == 1}
    }
    
    var body: some View {
        VStack{
            HStack{
                Text("Level-up Moves:")
                    .font(.system(.title2, design: .rounded))
                    .bold()
                    .multilineTextAlignment(.leading)
                Spacer()
                Button(action: {
                    self.showingMoves.toggle()
                }) {
                    if self.showingMoves {
                        Image(systemName: "chevron.down.circle")
                            .imageScale(.large)
                    }
                    if self.showingMoves==false {
                        Image(systemName: "chevron.left.circle")
                            .imageScale(.large)
                    }
                }
                .hoverEffect(.lift)
            }
            if self.showingMoves && pokemonMoveList.count > 0 {
                VStack{
                    HStack{
                        Text("Level")
                            .font(.caption)
                            .bold()
                        Spacer()
                        Text("Power/Type")
                            .font(.caption)
                            .bold()
                    }
                    .padding(.top, 4)
                    
                    ForEach(filteredPokemonMoveList.sorted{$0.level < $1.level}, id: \.id) { pokemonMove in
                        Divider()
                        
                        NavigationLink(destination: MoveDetailView(pokemonList: pokemonList,
                                                                   pokemonFormsList: pokemonFormsList,
                                                                   pokemonTypeList: pokemonTypeList,
                                                                   moveList: moveList,
                                                                   moveEffectList: moveEffectList,
                                                                   typeList: typeList,
                                                                   abilityList: abilityList,
                                                                   abilityProseList: abilityProseList,
                                                                   pokemonAbilitiesList: pokemonAbilitiesList,
                                                                   itemList: itemList, 
                                                                   move: self.findMove(moveID: pokemonMove.move_id, moveList: moveList))) {
                            moveRow(move: self.findMove(moveID: pokemonMove.move_id, moveList: moveList), pokemonMove: pokemonMove)
                        }
                        .background(Color(UIColor.secondarySystemBackground))
                        .hoverEffect()
                    }
                }
            } else {
                if pokemonMoveList.count == 0 {
                    Text("No moves found! Try changing versions in the upper-right corner. ")
                }
            }
        }
    }
    
    func findMove(moveID: Int, moveList: [Move]) -> Move {
        if let i = moveList.firstIndex(where: {$0.id == moveID}) {
            return moveList[i]
        }
        return Move()
    }
}


struct moveRow: View {
    let move: Move
    let pokemonMove: PokemonMove
    var typeList:  [Type] = Bundle.main.decode("types.json")
    
    var body: some View {
        VStack{
            HStack{
                
                Text(String(format: "%02d", self.pokemonMove.level))
                    .foregroundColor(Color(UIColor.label))
                    .bold()
                
                Text(self.move.wrappedName)
                    .font(.headline)
                
                Spacer()
                
                Text("\(self.move.wrappedPower)")
                
                ZStack {
                    Text("\(self.typeList[move.type_id-1].wrappedName)")
                    .foregroundColor(Color(UIColor.label))
                }.frame(width: 56, height: 28).background(typeColor(type: self.typeList[move.type_id-1].wrappedName)).cornerRadius(6).font(.caption)
                
                Image(systemName: "chevron.right")
            }
        }
    }
}
