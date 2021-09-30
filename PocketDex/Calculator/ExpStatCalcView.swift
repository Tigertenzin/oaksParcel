//
//  ExpStatCalcView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/27/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct ExpStatCalcView: View {
    
    enum ExpGroup: String, Equatable, CaseIterable {
        case erratic, fast, mediumfast, mediumslow, slow, fluctuating
    }
    
    @State var expGroup = ExpGroup.fast
    
    
    @State var on = true
    @State var sampleData: [CGFloat] = [0.1,0.3,0.2,0.4,0.3,0.5,0.4,0.6]
    @State private var minLevelShowing = 1
    @State private var maxLevelShowing = 100
    @State private var totVsNext = true
    
    var expData: [CGFloat] {
        var finalInt: [CGFloat] = []
        var tempVal: Float = 0
        if totVsNext {
            for level in minLevelShowing...maxLevelShowing {
                tempVal = expTotLevel(level: Float(level), expGroup: expGroup)/expTotLevel(level: Float(100), expGroup: expGroup)
                finalInt.append(CGFloat(tempVal))
            }
        } else {
            for level in minLevelShowing+1...maxLevelShowing {
                tempVal = (expTotLevel(level: Float(level), expGroup: expGroup)-expTotLevel(level: Float(level-1), expGroup: expGroup))/(expTotLevel(level: Float(100), expGroup: expGroup)-expTotLevel(level: Float(99), expGroup: expGroup))
                finalInt.append(CGFloat(tempVal))
            }
        }
        return finalInt
    }
    
    var body: some View {
        ScrollView(.vertical) {
            LineGraph(dataPoints: expData)
                .trim(to: on ? 1 : 0)
                .stroke(Color.red, lineWidth: 2)
                .aspectRatio(16/9, contentMode: .fit)
                .border(Color.gray, width: 1)
                .padding()
            Button("Animate") {
                withAnimation(.easeInOut(duration: 2)) {
                    self.on.toggle()
                }
            }
            List {
                Toggle(isOn: self.$totVsNext) {
                    Text("Cumulative")
                }
                Picker(selection: self.$expGroup, label: Text("Experience Group")) {
                    ForEach(ExpGroup.allCases, id: \.self) {
                            Text($0.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .listStyle(GroupedListStyle())
        
        }
        .navigationBarTitle("Exp Calculator")
    }
    
    func expTotLevel(level: Float, expGroup: ExpGroup) -> Float {
        switch expGroup {
        case .erratic:
            if level <= 50 {
                return level*level*level*(100-level)/50
            } else if level <= 68 {
                return level*level*level*(150-level)/100
            } else if level <= 98 {
                return level*level*level*(1950-10*level)/1500
            } else {
                return level*level*level*(160-level)/100
            }
        case .fast:
            return level*level*level*4/5
        case .mediumfast:
            return level*level*level
        case .mediumslow:
            return (level*level*level*6/5 - 15*level*level + 100*level - 140)
        case .slow:
            return level*level*level*5/4
        case .fluctuating:
            if level <= 15 {
                return level*level*level * ( ( (level+1)/3) + 24 ) / 50
            } else if level <= 36 {
                return level*level*level * ( ( level + 14 ) / 50)
            } else {
                return level*level*level * ( ( level/2 + 32 ) / 50)
            }
        }
    }
}

struct ExpStatCalcView_Previews: PreviewProvider {
    static var previews: some View {
        ExpStatCalcView()
    }
}
