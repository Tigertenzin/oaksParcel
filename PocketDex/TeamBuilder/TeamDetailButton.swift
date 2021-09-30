//
//  TeamDetailButton.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/21/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct TeamDetailButton2: View {
    let pkmn: Pokemon
    
    var pokemonTypeList:  [PokemonType] = Bundle.main.decode("pokemon_types.json")
    var typeList:  [Type] = Bundle.main.decode("types.json")
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 48, maxHeight: 128)
                .foregroundColor(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
            
            HStack{
                Spacer().frame(width: 12)
                
                Image(pkmn.imgName)
                .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                
                Text("\(pkmn.id) - \(pkmn.wrappedName)").font(.headline)
                
                Spacer()
                
                ForEach(self.getTypes(typeList: self.pokemonTypeList, pkmnID: pkmn.id), id: \.self) { type1 in
                    ZStack {
                        Text("\(self.typeList[type1.type_id - 1].wrappedName)")
                            .foregroundColor(Color(UIColor.label))
                    }
                        .frame(width: 56, height: 28)
                        .background(typeColor(type: self.typeList[type1.type_id - 1].wrappedName ))
                        .cornerRadius(12)
                        .font(.caption)
                }
                
                Spacer().frame(width: 12)
                
            }
        }
    }
    
    func getTypes(typeList: [PokemonType], pkmnID: Int) -> [PokemonType] {
        var resultTypes = [PokemonType]()
        
        if let i = typeList.firstIndex(where: {$0.pokemon_id == pkmnID }) {
            resultTypes.append(typeList[i])
            if typeList[i+1].pokemon_id == pkmnID {
                resultTypes.append(typeList[i+1])
            }
        }
        return resultTypes
    }
}
