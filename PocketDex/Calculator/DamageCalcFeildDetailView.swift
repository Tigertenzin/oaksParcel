//
//  DamageCalcFeildDetailView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/10/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct DamageCalcFeildDetailView: View {
    
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
    
    @Binding var modalView: ModalView
    @Binding var isSheetShown: Bool
    
    var yourSideEffects: [String] {
        var finalList = [String]()
        if screens1[0] == true {
            finalList.append("Reflect")
        }
        if screens1[1] == true {
            finalList.append("Light Screen")
        }
        if helpingHand1 == true {
            finalList.append("Helping Hand")
        }
        if auroraVeil1 == true {
            finalList.append("Auroral Veil")
        }
        return finalList
    }
    var foeSideEffects: [String] {
        var finalList = [String]()
        if screens2[0] == true {
            finalList.append("Reflect")
        }
        if screens2[1] == true {
            finalList.append("Light Screen")
        }
        if helpingHand2 == true {
            finalList.append("Helping Hand")
        }
        if auroraVeil2 == true {
            finalList.append("Auroral Veil")
        }
        return finalList
    }
    
    @EnvironmentObject var selectedTheme: UserTheme
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            HStack{
                Text("Field Effects")
                    .font(.system(.title2, design: .rounded))
                
                Spacer()
                
                Button(action: {
                    self.modalView = .field
                    print(self.modalView)
                    self.isSheetShown = true
                }) {
                    Text("Edit")
                }
            }
            
            Divider()
            VStack (alignment: .leading){
                VStack{
                    HStack {
                        Text("Battle Style:").font(.headline)
                        Text("\(battleStyleList[self.battleStyleSelection])")
                    }
                    
                    HStack {
                        Text("Terrain Effect:").font(.headline)
                        Text("\(terrainList[self.terrainSelection])")
                    }
                    
                    HStack {
                        Text("Weather Effect:").font(.headline)
                        Text("\(weatherList[self.weatherSelection])")
                    }
                }
                
                Divider()
                
                VStack{
                    HStack{
                        Text("Your Side: ")
                        TagCloudView(tags: yourSideEffects)
                    }
                }
                
                VStack{
                    HStack{
                        Text("Foe Side: ")
                        TagCloudView(tags: foeSideEffects)
                    }
                }
            }
        }
    }
}
