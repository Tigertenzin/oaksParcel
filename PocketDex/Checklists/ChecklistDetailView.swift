//
//  ChecklistDetailView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/26/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct ChecklistDetailView: View {
    @State var checklist: Checklist
    
    @State private var failsafe = [Int]()
    @State private var failsafeBool = [Bool]()
    
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var selectedTheme: UserTheme
    
    var pokemonList:  [Pokemon]
    
    var columns = [
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0)
    ]
    
    var body: some View {
        ScrollView {
            ForEach(0..<checklist.checklist_byID!.count/30+1, id: \.self) { j in
                
                if 30*(j+1) < checklist.checklist_byID!.count {
                    checkList_BoxFull(j: j, checklist: $checklist, pokemonList: pokemonList)
//                    VStack{
//                        HStack{
//                            Text("Box \(j+1): " + String(format: "%03d", j*30) + "-" + String(format: "%03d", j*30 + 30))
//                                .font(.system(.title2, design: .rounded))
//                                .bold()
//                                .layoutPriority(1)
//                            Spacer()
//
//                            Text("Mark All")
//                        }
//
//                        LazyVGrid(columns: columns, spacing: 0) {
//                            ForEach(30*j..<30*(j+1), id: \.self) { k in
//                                LivingDex_Button(pkmn: pokemonList[checklist.checklist_byID![k]], checked: $checklist.checklist, pos: k)
//                            }
//                        }
//                    }
//                    .padding()
//                    .background(Color(UIColor.secondarySystemBackground))
//                    .cornerRadius(12)
//                    .padding(.horizontal)
                } else {
                    
                    Text("Box \(j+1): " + String(format: "%03d", j*30) + "-" + String(format: "%03d", checklist.checklist_byID!.count))
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(30*j..<checklist.checklist_byID!.count, id: \.self) { k in
                            LivingDex_Button(pkmn: pokemonList[checklist.checklist_byID![k]], checked: $checklist.checklist, pos: k)
                        }
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarTitle(checklist.name ?? "Unknown Name")
    }
}


struct checkList_BoxFull: View {
    
    var j: Int
    @Binding var checklist: Checklist
    
    var pokemonList:  [Pokemon]
    var columns = [
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0)
    ]
    
    var body: some View {
        VStack{
            HStack{
                Text("Box \(j+1): " + String(format: "%03d", j*30) + "-" + String(format: "%03d", j*30 + 30))
                    .font(.system(.title2, design: .rounded))
                    .bold()
                    .layoutPriority(1)
                Spacer()
                
//                Button(action: {
//                    checklist[30*j..<30*j+30] = uncheckAll(checkListPart: checklist[30*j..<30*j+30])
//                }) {
////                    Text("\(uncheckAll_Bool(checkListPart: checklist[30*j..<30*j+30]))")
//                    Text("Toggle")
//                }
                
            }
            
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(30*j..<30*(j+1), id: \.self) { k in
                    LivingDex_Button(pkmn: pokemonList[checklist.checklist_byID![k]], checked: $checklist.checklist, pos: k)
                }
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .padding(.horizontal)
    }
    
//    var markAllButton: some View {
//        Button(action: {
//            checklist[30*j..<30*(j+1)] = uncheckAll(checkListPart: checklist[30*j..<30*(j+1)])
//        }) {
//            Text("\(uncheckAll_Bool(checkListPart: checklist[30*j..<30*(j+1)]))")
//        }
//    }
    
    func uncheckAll_Bool(checkListPart: [Bool]) -> String {
        if checkListPart.allSatisfy({ $0 == true }) {
            return "Unmark all"
        } else {
            return "Mark All"
        }
    }
    
    func uncheckAll(checkListPart: [Bool]) -> [Bool] {
        if checkListPart.allSatisfy({ $0 == true }) {
            return [Bool](repeating: false , count: checkListPart.count)
        } else {
            return [Bool](repeating: true, count: checkListPart.count)
        }
    }
}


struct LivingDex_Button: View {
    let pkmn: Pokemon
    @Binding var checked: [Bool]?
    @State var pos: Int

    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var selectedTheme: UserTheme
    
    var body: some View {
        Button(action: {
            self.checked?[pos].toggle()
            try? self.moc.save()
        }) {
            Image("\(pkmn.imgName)")
                .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                .overlay(
                    RoundedRectangle(cornerRadius: 12.0)
                        .stroke(lineWidth: 2.0)
                )
                .background(self.checked?[pos] ?? false ? selectedTheme.themeColor : Color.white)
                .cornerRadius(12)
                .padding(.bottom)
        }
    }
}
