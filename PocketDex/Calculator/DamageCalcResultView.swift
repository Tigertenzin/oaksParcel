//
//  DamageCalcResultView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/8/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct DamageCalcResultView: View {
    // Details on your pokemon for the calc
    @Binding var PKMN1: Pokemon
    @Binding var Move1_1: Move
    @Binding var Move2_1: Move
    @Binding var Move3_1: Move
    @Binding var Move4_1: Move
    var move1_1_damage: Double
    var move2_1_damage: Double
    var move3_1_damage: Double
    var move4_1_damage: Double
    
    // Details on the foe pokemon for the calc
    @Binding var PKMN2: Pokemon
    @Binding var Move1_2: Move
    @Binding var Move2_2: Move
    @Binding var Move3_2: Move
    @Binding var Move4_2: Move
    var move1_2_damage: Double
    var move2_2_damage: Double
    var move3_2_damage: Double
    var move4_2_damage: Double
    
    var columns: [GridItem] = [
        GridItem(.flexible(minimum: 64), spacing: 8),
        GridItem(.flexible(minimum: 64), spacing: 8)
    ]
    
    var body: some View {
        VStack{
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 0,
                pinnedViews: [.sectionHeaders, .sectionFooters]
            ) {
                Image(self.PKMN1.imgName)
                Image(self.PKMN2.imgName)
                
                Text(self.PKMN1.wrappedName)
                    .font(.headline)
                Text(self.PKMN2.wrappedName)
                    .font(.headline)
                
                Text(String(format: "%03d", PKMN1.id))
                    .font(.system(.body, design: .monospaced))
                Text(String(format: "%03d", PKMN2.id))
                    .font(.system(.body, design: .monospaced))
            }
            Divider()
                
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 0,
                pinnedViews: [.sectionHeaders, .sectionFooters]
            ) {
                DamageCalcResultMoveRow(Move1_1: $Move1_1, move1_1_damage: move1_1_damage)
                DamageCalcResultMoveRow(Move1_1: $Move1_2, move1_1_damage: move1_2_damage)
                
                DamageCalcResultMoveRow(Move1_1: $Move2_1, move1_1_damage: move2_1_damage)
                DamageCalcResultMoveRow(Move1_1: $Move2_2, move1_1_damage: move2_2_damage)
                
                DamageCalcResultMoveRow(Move1_1: $Move3_1, move1_1_damage: move3_1_damage)
                DamageCalcResultMoveRow(Move1_1: $Move3_2, move1_1_damage: move3_2_damage)
                
                DamageCalcResultMoveRow(Move1_1: $Move4_1, move1_1_damage: move4_1_damage)
                DamageCalcResultMoveRow(Move1_1: $Move4_2, move1_1_damage: move4_2_damage)
            }
        }
    }
}


struct DamageCalcResultMoveRow: View {
    @Binding var Move1_1: Move
    var move1_1_damage: Double
    
    var body: some View {
        if self.Move1_1.id>0 {
            Text("\(self.Move1_1.wrappedName): \(Int(0.85*move1_1_damage.rounded(.down)))-\(Int(move1_1_damage.rounded(.down)))")
        } else {
            Text("-")
        }
    }
}
