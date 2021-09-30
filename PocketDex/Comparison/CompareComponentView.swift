//
//  CompareComponentView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/13/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct CompareComponentView: View {
    
    var pokemonTypeList:  [PokemonType]
    var typeList:  [Type]
    var pokemonList:  [Pokemon]
    var moveList:  [Move]
    var moveEffectList:  [MoveEffectProse]
    var abilityList:  [Ability]
    var abilityProseList:  [AbilityProse]
    var pokemonAbilitiesList:  [PokemonAbilities]
    var pokemonStatList:  [PokemonStat]
    
    var comparisonList: [Pokemon]
    
    @State private var showingAddScreen = false
    @State private var showingHP = true
    @State private var showingAtk = true
    @State private var showingDef = true
    @State private var showingSpA = true
    @State private var showingSpD = true
    @State private var showingSpd = true
    
    let columns = [
            GridItem(.adaptive(minimum: 250))
        ]
    
    var body: some View {

        VStack {
            
            Text("Stat Comparison")
                .font(.headline)
            .cornerRadius(12)
            .padding()
            
            // Comparison of Stats
            LazyVGrid(columns: columns, spacing: 20) {
                Group {
                    // HP (-6)
                    VStack{
                        HStack{
                            Spacer()
                            Text("HP:")
                                .font(.headline)
                                .multilineTextAlignment(.leading)
                            Spacer()
                            Button(action: {
                                self.showingHP.toggle()
                            }) {
                                if self.showingHP {
                                    Image(systemName: "chevron.down.circle")
                                }
                                if self.showingHP==false {
                                    Image(systemName: "chevron.left.circle")
                                }
                            }.hoverEffect(.lift)
                        }
                        .padding(.bottom)
                        if self.showingHP {
                            ForEach(self.comparisonList, id: \.id) { pkmn in
                                StatView(baseStat: self.pokemonStatList[pkmn.id*6 - 6].base_stat,
                                         imgName: pkmn.imgName,
                                         statColor: UIColor.systemRed)
                            }
                        }
                    }
                    
                    // Attack (-5)
                    VStack{
                        HStack{
                            Spacer()
                            Text("Attack:")
                                .font(.system(.headline, design: .rounded))
                                .multilineTextAlignment(.leading)
                            Spacer()
                            Button(action: {
                                self.showingAtk.toggle()
                            }) {
                                if self.showingAtk {
                                    Image(systemName: "chevron.down.circle")
                                }
                                if self.showingAtk==false {
                                    Image(systemName: "chevron.left.circle")
                                }
                            }.hoverEffect(.lift)
                        }
                        .padding(.bottom)
                        if self.showingAtk {
                            ForEach(self.comparisonList, id: \.id) { pkmn in
                                StatView(baseStat: self.pokemonStatList[pkmn.id*6 - 5].base_stat,
                                         imgName: pkmn.imgName, statColor: UIColor.systemOrange)
                            }
                        }
                    }
                    
                    // Defense (-4)
                    VStack{
                        HStack{
                            Spacer()
                            Text("Defense:")
                                .font(.system(.headline, design: .rounded))
                                .multilineTextAlignment(.leading)
                            Spacer()
                            Button(action: {
                                self.showingDef.toggle()
                            }) {
                                if self.showingDef {
                                    Image(systemName: "chevron.down.circle")
                                }
                                if self.showingDef==false {
                                    Image(systemName: "chevron.left.circle")
                                }
                            }.hoverEffect(.lift)
                        }
                        .padding(.bottom)
                        if self.showingDef {
                            ForEach(self.comparisonList, id: \.id) { pkmn in
                                StatView(baseStat: self.pokemonStatList[pkmn.id*6 - 4].base_stat,
                                         imgName: pkmn.imgName, statColor: UIColor.systemYellow)
                            }
                        }
                    }
                    
                    // Sp Attack (-3)
                    VStack{
                        HStack{
                            Spacer()
                            Text("Special Attack:")
                                .font(.system(.headline, design: .rounded))
                                .multilineTextAlignment(.leading)
                            Spacer()
                            Button(action: {
                                self.showingSpA.toggle()
                            }) {
                                if self.showingSpA {
                                    Image(systemName: "chevron.down.circle")
                                }
                                if self.showingSpA==false {
                                    Image(systemName: "chevron.left.circle")
                                }
                            }.hoverEffect(.lift)
                        }
                        .padding(.bottom)
                        if self.showingSpA {
                            ForEach(self.comparisonList, id: \.id) { pkmn in
                                StatView(baseStat: self.pokemonStatList[pkmn.id*6 - 3].base_stat,
                                         imgName: pkmn.imgName, statColor: UIColor.systemBlue)
                            }
                        }
                    }
                    
                    // Sp Def (-2)
                    VStack{
                        HStack{
                            Spacer()
                            Text("Special Defense:")
                                .font(.system(.headline, design: .rounded))
                                .multilineTextAlignment(.leading)
                            Spacer()
                            Button(action: {
                                self.showingSpD.toggle()
                            }) {
                                if self.showingSpD {
                                    Image(systemName: "chevron.down.circle")
                                }
                                if self.showingSpD==false {
                                    Image(systemName: "chevron.left.circle")
                                }
                            }.hoverEffect(.lift)
                        }
                        .padding(.bottom)
                        if self.showingSpD {
                            ForEach(self.comparisonList, id: \.id) { pkmn in
                                StatView(baseStat: self.pokemonStatList[pkmn.id*6 - 2].base_stat,
                                         imgName: pkmn.imgName, statColor: UIColor.systemGreen)
                            }
                        }
                    }
                    
                    // Speed (-1)
                    VStack{
                        HStack{
                            Spacer()
                            Text("Speed:")
                                .font(.system(.headline, design: .rounded))
                                .multilineTextAlignment(.leading)
                            Spacer()
                            Button(action: {
                                self.showingSpd.toggle()
                            }) {
                                if self.showingSpd {
                                    Image(systemName: "chevron.down.circle")
                                }
                                if self.showingSpd==false {
                                    Image(systemName: "chevron.left.circle")
                                }
                            }.hoverEffect(.lift)
                        }
                        .padding(.bottom)
                        if self.showingSpd {
                            ForEach(self.comparisonList, id: \.id) { pkmn in
                                StatView(baseStat: self.pokemonStatList[pkmn.id*6 - 1].base_stat,
                                         imgName: pkmn.imgName, statColor: UIColor.systemPink)
                            }
                        }
                    }
                    
                }
                    .padding()
                    .fixedSize(horizontal: false, vertical: true)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    .animation(.default)
                    .padding(.bottom)
            }
            
        }
        .padding(.horizontal)
    }
}
