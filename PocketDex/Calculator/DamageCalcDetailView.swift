//
//  DamageCalcDetailView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/9/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct DamageCalcDetailView: View {
    var pokemonList:  [Pokemon]
    var pokemonTypeList:  [PokemonType]
    var pokemonStatList:  [PokemonStat]
    var typeList:  [Type]
    var moveList:  [Move]
    
    var yourMon: Bool
    
    @Binding var PKMN1: Pokemon
    @Binding var level1: Double
    @Binding var gender1: Int
    @Binding var ability1: Ability
    @Binding var nature1: Int
    @Binding var status1: Int
    @Binding var EVs1: [Double]
    @Binding var IVs1: [Double]
    @Binding var Mods1: [Double]
    @Binding var Move1_1: Move
    @Binding var Move2_1: Move
    @Binding var Move3_1: Move
    @Binding var Move4_1: Move
    @Binding var modalView: ModalView
    @Binding var isSheetShown: Bool
    var types1: [PokemonType]
    
    var genderList = ["Male", "Female", "No Gender"]
    var statTypeList = ["HP", "Atk.", "Def.", "Sp. Atk.", "Sp. Def.", "Speed"]
    var natureList = ["Hardy", "Lonely (+Atk, -Def)", "Brave (+Atk, -Spd)", "Adamant (+Atk, -SpA)", "Naughty (+Atk, -SpD)", "Bold (+Def, -Atk)", "Docile", "Relaxed (+Def, -Spd)", "Impish (+Def, -SpA)", "Lax (+Def, -SpD)", "Timid (+Spd, -Atk)", "Hasty (+Spd, -Def)", "Serious", "Jolly (+Spd, -SpA)", "Naive (+Spd, -SpD)", "Modest (+SpA, -Atk)", "Mild (+SpA, -Def)", "Quiet (+SpA, -Spd)", "Bashful", "Rash (+SpA, -SpD)", "Calm (+SpD, -Atk)", "Gentle (+SpD, -Def)", "Sassy (+SpD, -Spd)", "Careful (+SpD, -SpA)", "Quirky"]
    var statusList = ["Healthy", "Poisoned", "Badly Poisoned", "Burned", "Paralyzed", "Asleep", "Frozen"]
    
    var genderColor: [Color] = [Color.blue, Color.pink, Color.gray]
    
    @State private var searchText = ""
    
    @EnvironmentObject var selectedTheme: UserTheme
    @Environment(\.presentationMode) var presentationMode
    
    var columns: [GridItem] = [
        GridItem(.flexible(minimum: 64), spacing: 8),
        GridItem(.flexible(minimum: 32), spacing: 8),
        GridItem(.flexible(minimum: 32), spacing: 8),
        GridItem(.flexible(minimum: 32), spacing: 8),
        GridItem(.flexible(minimum: 32), spacing: 8),
        GridItem(.flexible(minimum: 32), spacing: 8)
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                if yourMon {
                    Text("Your Pokemon")
                        .font(.system(.title2, design: .rounded))
                } else {
                    Text("Foe Pokemon")
                        .font(.system(.title2, design: .rounded))
                }
                Spacer()
                Button(action: {
                    print("PKMN1 selector")
                    if yourMon {
                        self.modalView = .pkmn1
                    } else {
                        self.modalView = .pkmn2
                    }
                    self.isSheetShown = true
                }) {
                    Text("Edit")
                }
            }
            
            Divider()
            // Pokemon Details
            HStack{
                Text("Pokemon:  ")
                Text(self.PKMN1.wrappedName)
                    .bold()
                Image(self.PKMN1.imgName)
                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
            }
            VStack (alignment: .leading){
                HStack{
//                    Text("Types: ")
                    ForEach(types1, id: \.type_id) { type1 in
                        Text("\(self.typeList[type1.type_id - 1].wrappedName)")
                            .frame(width: 56, height: 28)
                            .background(typeColor(type: self.typeList[type1.type_id - 1].wrappedName))
                            .cornerRadius(6)
                            .font(.caption)
                    }
                }
                
                TagCloudView(tags: ["Lv: "+String(format: "%g", level1), "\(genderList[gender1])", "\(ability1.wrappedName)", "Nature: \(natureList[nature1])", "No Item", "Status: \(statusList[status1])"])
            }
            
            Divider()
            // Stats, base, EVs, and IVs
            VStack{
                LazyVGrid(
                    columns: columns,
                    alignment: .center,
                    spacing: 0,
                    pinnedViews: [.sectionHeaders, .sectionFooters]
                ) {
                    Text(" ")
                    Text("Base").font(.caption).bold()
                    Text("EVs").font(.caption).bold()
                    Text("IVs").font(.caption).bold()
                    Text("Mod").font(.caption).bold()
                    Text("Total").font(.caption).bold()
                    
                    ForEach(0...5, id: \.self) { index in
                        Text("\(statTypeList[index])")
                        Text("\(self.pokemonStatList[PKMN1.id*6 - (6-index)].base_stat)")
                        Text("\(EVs1[index], specifier: "%g")")
                        Text("\(IVs1[index], specifier: "%g")")
                        Text("\(Mods1[index], specifier: "%g")")
                        if index == 0 {
                            Text("\(calcHP(baseHP: Double(self.pokemonStatList[PKMN1.id*6 - 6+index].base_stat), IV: self.IVs1[index], EV: self.EVs1[index], Level: self.level1, GenBelow3: false))")
                        } else {
                            Text("\(calcOther(base: Double(self.pokemonStatList[PKMN1.id*6 - 6+index].base_stat), type: index, IV: self.IVs1[index], EV: self.EVs1[index], Level: self.level1, nature: nature1, GenBelow3: false))")
                        }
                    }
                }
            }
            
            Divider()
            //Move Details
            VStack{
                HStack{
                    Text("Move 1: \(self.Move1_1.wrappedName)")
                    Spacer()
                }
                HStack{
                    Text("Move 2: \(self.Move2_1.wrappedName)")
                    Spacer()
                }
                HStack{
                    Text("Move 3: \(self.Move3_1.wrappedName)")
                    Spacer()
                }
                HStack{
                    Text("Move 4: \(self.Move4_1.wrappedName)")
                    Spacer()
                }
            }
            
        }
    }
}


