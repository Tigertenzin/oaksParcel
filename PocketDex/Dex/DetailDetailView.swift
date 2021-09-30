//
//  DetailDetailView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/18/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct DetailDetailView: View {
    @EnvironmentObject var selectedTheme: UserTheme
    let pkmn: Pokemon
    
    @Binding var showingDetails: Bool
    
    var body: some View {
        VStack{
            HStack{
                Text("Biology")
                    .font(.system(.title2, design: .rounded))
                    .bold()
                    .multilineTextAlignment(.leading)
                Spacer()
                Button(action: {
                    self.showingDetails.toggle()
                }) {
                    if self.showingDetails {
                        Image(systemName: "chevron.down.circle")
                            .imageScale(.large)
                    }
                    if self.showingDetails==false {
                        Image(systemName: "chevron.left.circle")
                            .imageScale(.large)
                    }
                }.hoverEffect(.lift)
            }
            .padding(.bottom, 4)
            
            if self.showingDetails {
                
                HStack{
                    Text("Height: ")
                        .bold()
                    Spacer()
                    Text("\(self.pkmn.wrappedHeight, specifier: "%.2f") m")
                }
                .padding(.bottom, 2)
                
                HStack{
                    Text("Weight: ")
                        .bold()
                    Spacer()
                    Text("\(self.pkmn.wrappedWeight, specifier: "%.1f") Kg")
                }
                .padding(.bottom, 2)

                VStack(spacing: 2) {
                    HStack{
                        Text("Base Capture Rate: ")
                            .bold()
                        Spacer()
                        Text("\(self.speciesDetailsFromId(speciesID: self.pkmn.id).capture_rate)")
                    }

                    GeometryReader { geometry in
                        Rectangle()
                            .frame(width: geometry.size.width, height: 12)
                            .foregroundColor(Color(UIColor.systemFill))
                            .cornerRadius(4)
                        Rectangle()
                            .frame(width: geometry.size.width * CGFloat(self.speciesDetailsFromId(speciesID: self.pkmn.id).capture_rate)/255, height: 12)
                            .foregroundColor(selectedTheme.themeColor)
                            .cornerRadius(4)
                    }
                }
                .frame(height: 40)
                
                VStack(spacing: 2) {
                    HStack{
                        Text("Base Happiness: ")
                            .bold()
                        Spacer()
                        Text("\(self.speciesDetailsFromId(speciesID: self.pkmn.id).base_happiness)")
                    }

                    GeometryReader { geometry in
                        Rectangle()
                            .frame(width: geometry.size.width, height: 12)
                            .foregroundColor(Color(UIColor.systemFill))
                            .cornerRadius(4)
                        Rectangle()
                            .frame(width: geometry.size.width * CGFloat(self.speciesDetailsFromId(speciesID: self.pkmn.id).base_happiness)/255, height: 12)
                            .foregroundColor(selectedTheme.themeColor)
                            .cornerRadius(4)
                    }
                }
                .frame(height: 40)
                
                HStack{
                    Text("Growth Rate: ")
                        .bold()
                    Spacer()
                    Text("\(self.speciesDetailsFromId(speciesID: self.pkmn.id).growth_rate_prose)")
                }
            }
        }
    }
    
    func speciesDetailsFromId(speciesID: Int) -> PokemonSpecies {
        let pokemonSpeciesList: [PokemonSpecies] = Bundle.main.decode("pokemon_species.json")
        
        if let i = pokemonSpeciesList.firstIndex(where: {$0.id == speciesID }) {
            return pokemonSpeciesList[i]
        }
        return pokemonSpeciesList[0]
        
    }
}
//
//struct DetailDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailDetailView()
//    }
//}
