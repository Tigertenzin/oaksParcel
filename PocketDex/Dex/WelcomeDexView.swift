//
//  WelcomeDexView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/17/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct WelcomeDexView: View {
    var pokemonList:  [Pokemon]
    @EnvironmentObject var selectedTheme: UserTheme
    
    let columns = [
        GridItem(.adaptive(minimum: 50))
    ]
    
    var body: some View {
        ZStack {
            if selectedTheme.showSprites {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(Array(pokemonList[0...806]).shuffled(), id: \.self) { item in
                        Image(item.imgName)
                            .opacity(0.3)
                    }
                }
                .padding(.horizontal)
            }
            
            VStack{
                Text("Welcome!")
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                    .padding(.bottom)

                Text("Please select a Pokemon from the left-hand menu. Swipe from the left edge to show it.")
            }
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(12)
            .hoverEffect(.highlight)
            .padding()
        }
    }
}
