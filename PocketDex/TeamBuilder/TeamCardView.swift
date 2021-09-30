//
//  TeamCardView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/24/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct TeamCardView: View {
    @State var team: Team_1
    var pokemonList:  [Pokemon]
    var setList: [Bool]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(team.name ?? "Unknown Name")")
                .font(.headline)
            
            HStack{
//                if setList[0] {
//                    Image(self.pokemonList[Int(team.pkmn1ID)-1].imgName)
//                }
//                if setList[1] {
//                    Image(self.pokemonList[Int(team.pkmn2ID)-1].imgName)
//                }
//                if setList[2] {
//                    Image(self.pokemonList[Int(team.pkmn3ID)-1].imgName)
//                }
//                if setList[3] {
//                    Image(self.pokemonList[Int(team.pkmn4ID)-1].imgName)
//                }
//                if setList[4] {
//                    Image(self.pokemonList[Int(team.pkmn5ID)-1].imgName)
//                }
//                if setList[5] {
//                    Image(self.pokemonList[Int(team.pkmn6ID)-1].imgName)
//                }
                Image(self.pokemonList[Int(team.pkmn1ID)-1].imgName)
                Image(self.pokemonList[Int(team.pkmn2ID)-1].imgName)
                Image(self.pokemonList[Int(team.pkmn3ID)-1].imgName)
                Image(self.pokemonList[Int(team.pkmn4ID)-1].imgName)
                Image(self.pokemonList[Int(team.pkmn5ID)-1].imgName)
                Image(self.pokemonList[Int(team.pkmn6ID)-1].imgName)
                Spacer()
            }
        }
//        .padding()
//        .fixedSize(horizontal: false, vertical: true)
//        .background(Color(UIColor.secondarySystemBackground))
//        .cornerRadius(12)
//        .animation(.default)
    }
}

