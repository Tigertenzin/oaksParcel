//
//  CompareView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/13/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct CompareView: View {
    @EnvironmentObject var selectedTheme: UserTheme
    
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
    var pokemonStatList:  [PokemonStat]
    
    @State private var showingAddScreen = false
    @State private var showingHP = true
    @State private var showingAtk = true
    @State private var showingDef = true
    @State private var showingSpA = true
    @State private var showingSpD = true
    @State private var showingSpd = true
    
    @State private var comparisonList = [Pokemon]()
    
    @State private var pkmn2 = Pokemon()
    @State private var searchText = ""
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    
                    // Display each pkmn in the comaprison
                    if comparisonList.count > 0 {
                        HStack {
                            Spacer()
                            ForEach(self.comparisonList, id: \.id) { pkmn in
                                
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
//                                                                       otherForms: getOtherForms(inputPokemon: pkmn, pokemonList: pokemonList),
                                                                       pkmn: pkmn)) {
                                    VStack{
                                        Image(pkmn.imgName)
                                            .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
//                                        Text(pkmn.id)
//                                            .font(.system(.body, design: .monospaced))
                                    }
                                }
                                
                            }
                            Spacer()
                        }
                        .padding()
                        .frame(width: geo.size.width)
                        .fixedSize(horizontal: false, vertical: true)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                        .animation(.default)
                        .padding(.bottom)
                    }
                    
                    // Comparison of Stats
                    Group{
                        // HP (-6)
                        VStack{
                            HStack{
                                Spacer()
                                Text("HP:")
                                    .font(.system(.headline, design: .rounded))
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
                    .frame(width: geo.size.width)
                    .fixedSize(horizontal: false, vertical: true)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    .animation(.default)
                    .padding(.bottom)
                    
                }
            }
            .sheet(isPresented: self.$showingAddScreen) {
                CompareAddView(pokemonList: pokemonList, comparisonList: self.$comparisonList, isPresented: self.$showingAddScreen)
                    .accentColor(self.selectedTheme.themeColor)
            }
            .navigationBarTitle("Compare")
            .navigationBarItems(trailing:
                HStack{
                    Menu {
                        
                        Button(action: {
                            self.showingAddScreen.toggle()
                        }) {
                            Image(systemName: "plus.circle.fill")
                            Text("Add to Comparison")
                        }
                        
                        Button(action: {
                            self.showingHP = false
                            self.showingAtk = false
                            self.showingDef = false
                            self.showingSpA = false
                            self.showingSpD = false
                            self.showingSpd = false
                        }) {
                            HStack {
                                Image(systemName: "eye.slash")
                                Text("Hide all sections")
                            }
                        }
                        Button(action: {
                            self.comparisonList = [Pokemon]()
                        }) {
                            HStack {
                                Image(systemName: "trash")
                                Text("Reset Comparison")
                            }
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .imageScale(.large)
                    }
                    
                }
             )
        }
        .padding(.horizontal)
    }
}



struct StatView: View {
    let baseStat: Int
    let imgName: String
    let statColor: UIColor
    
    var body: some View {
        HStack{
            Image(imgName)
                .resizable()
                .frame(width: 16, height: 16)
            GeometryReader { geometry in
                Rectangle()
                    .frame(width: geometry.size.width, height: 16)
                    .foregroundColor(Color(UIColor.systemFill))
                    .cornerRadius(4)
                Rectangle()
                    .frame(width: geometry.size.width * self.statFill(stat: self.baseStat), height: 16)
                    .foregroundColor(Color(self.statColor))
                    .cornerRadius(4)
            }
            Text("\(self.baseStat)")
        }
    }
    
    func statFill(stat: Int) -> CGFloat {
        return CGFloat(Float(stat) / 200)
    }
}




struct BarView: View{

    var value: CGFloat
    var cornerRadius: CGFloat
    var statColor: Color
    
    var body: some View {
        VStack {

            ZStack (alignment: .bottom) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: 30, height: 200).foregroundColor(Color(UIColor.secondarySystemBackground))
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: 30, height: value).foregroundColor(.green)
                
            }.padding(.bottom, 8)
            
            Text("\(Int(value))")
        }
        
    }
}
