
//
//  TeamView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/19/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct TeamView: View {
    let team: Team
    
    var body: some View {
        VStack {
            HStack {
                Text("\(team.name)")
                .font(.headline)
                Spacer()
                VStack{
                    HStack{
                        Image(team.PKMN1
                            .imgName)
                        Image(team.PKMN2
                        .imgName)
                        Image(team.PKMN3
                        .imgName)
                    }
                    HStack{
                        Image(team.PKMN4
                        .imgName)
                        Image(team.PKMN5
                        .imgName)
                        Image(team.PKMN6
                        .imgName)
                    }
                }
            }
        }
//        .cornerRadius(10)
//        .overlay(
//            RoundedRectangle(cornerRadius: 10)
//                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
//        )
//        .padding([.top, .horizontal])
    }
}
