//
//  TypeMatchupView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/14/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct TypeMatchupView: View {
    var typeList:  [Type]
    
    @State private var sortBy = 0
    
    var sortedTypeList: [Type] {
        if sortBy == 0 {
            return Array(typeList[0...17]).sorted{$0.id < $1.id}
        } else if sortBy == 1 {
            return Array(typeList[0...17]).sorted{$0.wrappedName < $1.wrappedName}
        } else {
            return Array(typeList[0...17])
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                
                ForEach(sortedTypeList, id: \.self) { type in
                    VStack {
                        HStack{
                            Text("\(type.wrappedName)")
                            .font(.system(.title2, design: .rounded))
                            .bold()
                            .layoutPriority(1)
                            
                            Spacer()
                        }
                        
                        HStack{
                            Text("Super Effective (x2 damage): ")
                            Spacer()
                        }
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(sortedTypeList, id: \.self) { type1 in
                                    if typeEffec2(type1: type, type2: type1)==2 {
                                        Text("\(type1.wrappedName)")
                                            .frame(width: 64, height: 36)
                                            .background(typeColor(type: type1.wrappedName))
                                            .cornerRadius(6)
                                    }
                                }
                            }
                        }
                        
                        HStack{
                            Text("Not Very Effective (x1/2 damage): ")
                            Spacer()
                        }
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(sortedTypeList, id: \.self) { type1 in
                                    if typeEffec2(type1: type, type2: type1)==0.5 {
                                        Text("\(type1.wrappedName)")
                                            .frame(width: 64, height: 36)
                                            .background(typeColor(type: type1.wrappedName))
                                            .cornerRadius(6)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .frame(width: geo.size.width)
                    .fixedSize(horizontal: false, vertical: true)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                }
            }
        }
        .padding(.horizontal)
        .navigationBarTitle("Type Matchups")
        .navigationBarItems(trailing:
            HStack{
                Menu {
                    Button(action: {
                        sortBy = 1
                    }) {
                        HStack {
                            Image(systemName: "textformat.alt")
                            Text("Sort by name")
                        }
                    }
                    
                    Button(action: {
                        sortBy = 0
                    }) {
                        HStack {
                            Image(systemName: "textformat.123")
                            Text("Sort by ID")
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .imageScale(.large)
                }
                
            }
         )
    }
}


