//
//  DetailTypeMatchupView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/19/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct DetailTypeMatchupView: View {
    
    let pkmn: Pokemon
    var pokemonTypeList:  [PokemonType]
    var typeList: [Type]
    @Binding var showingTypes: Bool
    
    var sortedTypeList: [Type] {
        return Array(typeList[0...17]).sorted{$0.wrappedName < $1.wrappedName}
    }
    var pkmn_types: [PokemonType] {
        return getTypes(typeList: self.pokemonTypeList, pkmnID: self.pkmn.id)
    }
    var types: [Type] {
        var empty = [Type]()
        for pkmnType in pkmn_types {
            empty.append(self.typeList[pkmnType.type_id - 1])
        }
        return empty
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        VStack{
            HStack{
               Text("Type Effectiveness")
                .font(.system(.title2, design: .rounded))
                .bold()
                .multilineTextAlignment(.leading)
                Spacer()
                Button(action: {
                    self.showingTypes.toggle()
                }) {
                    if self.showingTypes {
                        Image(systemName: "chevron.down.circle").imageScale(.large)
                    }
                    if self.showingTypes==false {
                        Image(systemName: "chevron.left.circle").imageScale(.large)
                    }
                }.hoverEffect()
            }
            if showingTypes {
                VStack{
                    VStack{
                        HStack{
                            Text("Weak to:")
                                .font(.system(.headline, design: .rounded))
                            Spacer()
                        }
                        .padding(.top, 6)
                        LazyVGrid(columns: columns, spacing: 5) {
                            ForEach(sortedTypeList, id: \.self) { type1 in
                                if typEffectTot(type1: type1, type2s: types) >= 2 {
                                    HStack{
                                        Text("\(type1.wrappedName)")
                                            .font(.footnote)
                                        Text("x\(formatEffec(effec: typEffectTot(type1: type1, type2s: types)))")
                                            .font(.caption)
                                            .bold()
                                            .fixedSize(horizontal: true, vertical: false)
                                            .padding(4)
                                            .background(Color(UIColor.systemGray5))
                                            .cornerRadius(8)
                                    }
                                    .frame(minWidth: 100, minHeight: 36)
                                    .background(typeColor(type: type1.wrappedName))
                                    .cornerRadius(8)
                                }
                            }
                        }
                    }
                    
                    VStack{
                        HStack{
                            Text("Resistant to:")
                                .font(.system(.headline, design: .rounded))
                            Spacer()
                        }
                        LazyVGrid(columns: columns, spacing: 5) {
                            ForEach(sortedTypeList, id: \.self) { type1 in
                                if typEffectTot(type1: type1, type2s: types) <= 0.6 && typEffectTot(type1: type1, type2s: types) > 0 {
                                    HStack{
                                        Text("\(type1.wrappedName)")
                                            .font(.footnote)
                                        Text("x\(formatEffec(effec: typEffectTot(type1: type1, type2s: types)))")
                                            .font(.caption)
                                            .bold()
                                            .fixedSize(horizontal: true, vertical: false)
                                            .padding(4)
                                            .background(Color(UIColor.systemGray5))
                                            .cornerRadius(8)
                                    }
                                    .frame(minWidth: 100, minHeight: 36)
                                    .background(typeColor(type: type1.wrappedName))
                                    .cornerRadius(8)
                                }
                            }
                        }
                    }
                    
                    VStack{
                        HStack{
                            Text("Immune to:")
                                .font(.system(.headline, design: .rounded))
                            Spacer()
                        }
                        LazyVGrid(columns: columns, spacing: 5) {
                            ForEach(sortedTypeList, id: \.self) { type1 in
                                if typEffectTot(type1: type1, type2s: types) == 0 {
                                    HStack{
                                        Text("\(type1.wrappedName)")
                                            .font(.footnote)
                                        Text("x\(formatEffec(effec: typEffectTot(type1: type1, type2s: types)))")
                                            .font(.caption)
                                            .bold()
                                            .fixedSize(horizontal: true, vertical: false)
                                            .padding(4)
                                            .background(Color(UIColor.systemGray5))
                                            .cornerRadius(8)
                                    }
                                    .frame(minWidth: 100, minHeight: 36)
                                    .background(typeColor(type: type1.wrappedName))
                                    .cornerRadius(8)
                                }
                            }
                        }
                    }
                    
                    VStack{
                        HStack{
                            Text("Damaged normally by:")
                                .font(.system(.headline, design: .rounded))
                            Spacer()
                        }
                        LazyVGrid(columns: columns, spacing: 5) {
                            ForEach(sortedTypeList, id: \.self) { type1 in
                                if typEffectTot(type1: type1, type2s: types) == 1 {
                                    HStack{
                                        Text("\(type1.wrappedName)")
                                            .font(.footnote)
                                        Text("x\(formatEffec(effec: typEffectTot(type1: type1, type2s: types)))")
                                            .font(.caption)
                                            .bold()
                                            .fixedSize(horizontal: true, vertical: false)
                                            .padding(3)
                                            .background(Color(UIColor.systemGray5))
                                            .cornerRadius(8)
                                    }
                                    .frame(minWidth: 100, minHeight: 36)
                                    .background(typeColor(type: type1.wrappedName))
                                    .cornerRadius(8)
                                }
                            }
                        }
                    }
//                    .padding()
//                    .background(Color(UIColor.tertiarySystemFill))
//                    .cornerRadius(8)
                }
            }
        }
    }
    func typEffectTot(type1: Type, type2s: [Type]) -> Double {
        // Type1 is the attacking move type
        // Type2 is the receiving type
        var effectiveness: Double = 1
        for type in type2s {
            effectiveness *= typeEffec2(type1: type1, type2: type)
        }
        return effectiveness
    }
    
    func formatEffec(effec: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: NSNumber(value: effec))!
    }
}
