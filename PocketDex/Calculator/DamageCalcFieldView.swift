//
//  DamageCalcFieldView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/10/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct DamageCalcFieldView: View {
    
    @Binding var battleStyleSelection: Int
    let battleStyleList: [String] = ["Singles", "Doubles"]
    
    @Binding var terrainSelection: Int
    let terrainList: [String] = ["None", "Electric", "Grassy", "Misty", "Psychic"]
    
    @Binding var weatherSelection: Int
    let weatherList: [String] = ["None", "Sun", "Rain", "Sandstorm", "Hail", "Harsh Sunshine", "Heavy Rain", "Strong Winds"]
    
    @Binding var gravity: Bool
    @Binding var screens1: [Bool]
    @Binding var helpingHand1: Bool
    @Binding var auroraVeil1: Bool
    @Binding var screens2: [Bool]
    @Binding var helpingHand2: Bool
    @Binding var auroraVeil2: Bool
    
    @EnvironmentObject var selectedTheme: UserTheme
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Battle Style:").font(.headline)
                    Picker(selection: $battleStyleSelection, label: Text("Battle Style: ")) {
                        ForEach(0..<battleStyleList.count, id: \.self) { index in
                            Text(self.battleStyleList[index])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    Text("Terrain Effect:").font(.headline)
                    Picker(selection: $terrainSelection, label: Text("Battle Style: ")) {
                        ForEach(0..<terrainList.count, id: \.self) { index in
                            Text(self.terrainList[index])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    Picker("Weather Effect: ", selection: $weatherSelection) {
                        ForEach(0..<weatherList.count, id: \.self) {
                            Text("\(self.weatherList[$0])")
                        }
                    }
                    
                    Toggle(isOn: $gravity) {
                        Text("Gravity: ")
                    }
                }
                
                Section (header: Text("Your Side")) {
                    Toggle(isOn: $screens1[0]) {
                        Text("Reflect: ")
                    }
                    Toggle(isOn: $screens1[1]) {
                        Text("Light Screen: ")
                    }
                    
                    Toggle(isOn: $helpingHand1) {
                        Text("Helping Hand: ")
                    }
                    
                    Toggle(isOn: $auroraVeil1) {
                        Text("Aurora Veil: ")
                    }
                }
                
                Section (header: Text("Foe Side")) {
                    Toggle(isOn: $screens2[0]) {
                        Text("Reflect: ")
                    }
                    Toggle(isOn: $screens2[1]) {
                        Text("Light Screen: ")
                    }
                    
                    Toggle(isOn: $helpingHand2) {
                        Text("Helping Hand: ")
                    }
                    
                    Toggle(isOn: $auroraVeil2) {
                        Text("Aurora Veil: ")
                    }
                }
                
                Text("\(battleStyleSelection), \(terrainSelection), \(weatherSelection)")
            }
            .navigationBarTitle("Select Field Effects")
            .navigationBarItems(
                trailing: Button("Done") {
                    self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
