//
//  DetailOtherMovesView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/18/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct DetailOtherMovesView: View {
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
    @Binding var showingOtherMoves: Bool
    
    var methodFilter: Int = 1
    var otherMoveMethods = [2, 3, 4]
    var otherMoveMethodNames = ["Breeding", "Tutor", "TM/HM"]
    @State private var chosenMoveMethod = 2
    var versionFilter: Int {
        return selectedVersion.versionOrder
    }
    
    var filteredPokemonMoveList: [PokemonMove] {
        return pokemonMoveList//.filter{$0.pokemon_move_method_id == methodFilter}
    }
    
    var body: some View {
        VStack{
            HStack{
                Text("More Moves")
                    .font(.system(.title2, design: .rounded))
                    .bold()
                    .multilineTextAlignment(.leading)
                Spacer()
                Button(action: {
                    self.showingOtherMoves.toggle()
                }) {
                    if self.showingOtherMoves {
                        Image(systemName: "chevron.down.circle")
                            .imageScale(.large)
                    }
                    if self.showingOtherMoves == false {
                        Image(systemName: "chevron.left.circle")
                            .imageScale(.large)
                    }
                }.hoverEffect(.lift)
            }
            if self.showingOtherMoves {
                VStack{
                    Picker(selection: self.$chosenMoveMethod, label: Text("What other move types do you want to see?")) {
                        ForEach(0 ..< self.otherMoveMethods.count) { index in
                            Text(self.otherMoveMethodNames[index])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    HStack{
                        Text("Move name")
                            .font(.caption)
                            .bold()
                        Spacer()
                        Text("Power/Type")
                            .font(.caption)
                            .bold()
                    }
                    .padding(.top, 4)
                    
                    
                    ForEach(self.pokemonMoveList.filter{$0.pokemon_move_method_id == self.chosenMoveMethod+2}, id: \.id) { pokemonMove in
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
                            otherMoveRow(move: self.findMove(moveID: pokemonMove.move_id, moveList: moveList), pokemonMove: pokemonMove)
                        }
                    }
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

struct otherMoveRow: View {
    let move: Move
    let pokemonMove: PokemonMove
    var typeList:  [Type] = Bundle.main.decode("types.json")
    
    var body: some View {
        VStack{
            Divider()
            
            HStack{
                
                Text(self.move.wrappedName)
                    .font(.headline)
                    .hoverEffect(.highlight)
                
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
