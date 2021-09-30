//
//  DetailStatsView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/18/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct StatsView: View {
    var pokemonStatList:  [PokemonStat] = Bundle.main.decode("pokemon_stats.json")
    var pokemonTypeList:  [PokemonType]
    var typeList:  [Type]
    
    let pkmnid: Int
    @Binding var showingStats: Bool
    
    var body: some View {
        
        VStack{
            HStack{
                
                Text("Stats")
                    .font(.system(.title2, design: .rounded))
                    .bold()
                    .multilineTextAlignment(.leading)
                Spacer()
                Button(action: {
                    self.showingStats.toggle()
                }) {
                    if self.showingStats {
                        Image(systemName: "chevron.down.circle").imageScale(.large)
                    }
                    if self.showingStats==false {
                        Image(systemName: "chevron.left.circle").imageScale(.large)
                    }
                }.hoverEffect(.lift)
            }
            .padding(.bottom, 4)
            
            if self.showingStats {
            VStack(spacing: 4) {
                VStack(spacing: 2) {
                    HStack{
                        Text("HP: ")
                            .bold()
                        Spacer()
                        Text("\(self.pokemonStatList[pkmnid*6 - 6].base_stat)")
                    }

                    GeometryReader { geometry in
                        Rectangle()
                            .frame(width: geometry.size.width, height: 12)
                            .foregroundColor(Color(UIColor.systemFill))
                            .cornerRadius(4)
                        Rectangle()
                            .frame(width: geometry.size.width * self.statFill(stat: self.pokemonStatList[pkmnid*6 - 6].base_stat), height: 12)
                            .foregroundColor(Color(UIColor.systemRed))
                            .cornerRadius(4)
                    }
                }
                .frame(height: 40)

                VStack(spacing: 2) {
                    HStack{
                        Text("Attack: ")
                            .bold()
                        Spacer()
                        Text("\(self.pokemonStatList[pkmnid*6 - 5].base_stat)")
                    }

                    GeometryReader { geometry in
                        Rectangle()
                            .frame(width: geometry.size.width, height: 12)
                            .foregroundColor(Color(UIColor.systemFill))
                            .cornerRadius(4)
                        Rectangle()
                            .frame(width: geometry.size.width * self.statFill(stat: self.pokemonStatList[pkmnid*6 - 5].base_stat), height: 12)
                            .foregroundColor(Color(UIColor.systemOrange))
                            .cornerRadius(4)
                    }
                }
                .frame(height: 40)

                VStack(spacing: 2) {
                    HStack {
                        Text("Defense: ")
                                .bold()
                            Spacer()
                        Text("\(self.pokemonStatList[pkmnid*6 - 4].base_stat)")
                    }

                    GeometryReader { geometry in
                        Rectangle()
                            .frame(width: geometry.size.width, height: 12)
                            .foregroundColor(Color(UIColor.systemFill))
                            .cornerRadius(4)
                        Rectangle()
                            .frame(width: geometry.size.width * self.statFill(stat: self.pokemonStatList[pkmnid*6 - 4].base_stat), height: 12)
                            .foregroundColor(Color(UIColor.systemYellow))
                            .cornerRadius(4)
                    }
                }
                .frame(height: 40)

                VStack(spacing: 2) {
                    HStack {
                        Text("Sp. Atk: ")
                            .bold()
                        Spacer()
                        Text("\(self.pokemonStatList[pkmnid*6 - 3].base_stat)")
                    }

                    GeometryReader { geometry in
                        Rectangle()
                            .frame(width: geometry.size.width, height: 12)
                            .foregroundColor(Color(UIColor.systemFill))
                            .cornerRadius(4)
                        Rectangle()
                            .frame(width: geometry.size.width * self.statFill(stat: self.pokemonStatList[pkmnid*6 - 3].base_stat), height: 12)
                            .foregroundColor(Color(UIColor.systemBlue))
                            .cornerRadius(4)
                    }
                }
                .frame(height: 40)

                VStack(spacing: 2) {
                    HStack {
                        Text("Sp. Def: ")
                            .bold()
                        Spacer()
                        Text("\(self.pokemonStatList[pkmnid*6 - 2].base_stat)")
                    }

                    GeometryReader { geometry in
                        Rectangle()
                            .frame(width: geometry.size.width, height: 12)
                            .foregroundColor(Color(UIColor.systemFill))
                            .cornerRadius(4)
                        Rectangle()
                            .frame(width: geometry.size.width * self.statFill(stat: self.pokemonStatList[pkmnid*6 - 2].base_stat), height: 12)
                            .foregroundColor(Color(UIColor.systemGreen))
                            .cornerRadius(4)
                    }
                }
                .frame(height: 40)

                VStack(spacing: 2) {
                    HStack {
                        Text("Speed: ")
                            .bold()
                        Spacer()
                        Text("\(self.pokemonStatList[pkmnid*6 - 1].base_stat)")
                    }

                    GeometryReader { geometry in
                        Rectangle()
                            .frame(width: geometry.size.width, height: 12)
                            .foregroundColor(Color(UIColor.systemFill))
                            .cornerRadius(4)
                        Rectangle()
                            .frame(width: geometry.size.width * self.statFill(stat: self.pokemonStatList[pkmnid*6 - 1].base_stat), height: 12)
                            .foregroundColor(Color(UIColor.systemPink))
                            .cornerRadius(4)
                    }
                }
                .frame(height: 40)
            }
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
    
    func checkTypeExists(typeList: [PokemonType], pkmnID: Int, checkType: Int) -> Bool {
        let allTypeList = self.getTypes(typeList: self.pokemonTypeList, pkmnID: pkmnID)
        
        for type1 in allTypeList {
            if type1.type_id == checkType {
                return true
            }
        }
        return false
    }
    
    func statFill(stat: Int) -> CGFloat {
        return CGFloat(Float(stat) / 200)
    }
}

