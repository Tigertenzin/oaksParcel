//
//  DetailHeaderView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/27/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct DetailHeaderView: View {
    @EnvironmentObject var selectedTheme: UserTheme
    
    let pkmn: Pokemon
    var pokemonTypeList:  [PokemonType]
    var typeList:  [Type]
    var otherForms: [Pokemon]
    var otherFormsDetails: [Pokemon_Forms]
    
    @State var chosenFormImgIndex = 0
    
    var types: [PokemonType] {
        return self.getTypes(typeList: self.pokemonTypeList, pkmnID: self.pkmn.id)
    }
    
    var body: some View {
        VStack{
            HStack{
                Text(String(format: "%03d", self.pkmn.id))
                    .font(.system(.body, design: .monospaced))
                Spacer()
                HStack{
                    ForEach(types, id: \.type_id) { type1 in
                        Text("\(self.typeList[type1.type_id - 1].wrappedName)")
                            .frame(width: 56, height: 28)
                            .background(typeColor(type: self.typeList[type1.type_id - 1].wrappedName))
                            .cornerRadius(6)
                            .font(.caption)
                    }
                }
            }
            if selectedTheme.showSprites {
                if self.otherFormsDetails[self.chosenFormImgIndex].form_identifier == nil {
                    Image(String(pkmn.id))
                        .interpolation(.none)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                } else {
                    Image(String(pkmn.id)+"-"+String(self.otherFormsDetails[self.chosenFormImgIndex].form_identifier ?? ""))
                        .interpolation(.none)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                }
            }
            if otherFormsDetails.count > 1 {
                Picker(selection: self.$chosenFormImgIndex, label: Text("What form do you want to display?")) {
                    ForEach(0 ..< self.otherFormsDetails.count) { index in
                        Text(self.otherFormsDetails[index].wrappedform_identifier)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
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
    
    func typeColor(type: String) -> Color {
        // Returns the type for a corresponding color.
        if type == "Bug" {
            return Color(red: 0.682, green: 0.737, blue: 0.129, opacity: 1.000)
        } else if type == "Dark" {
            return Color(red: 0.443, green: 0.345, blue: 0.286, opacity: 1.000)
        } else if type == "Dragon" {
            return Color(red: 0.463, green: 0.373, blue: 0.839, opacity: 1.000)
        } else if type == "Electric" {
            return Color(red: 0.988, green: 0.769, blue: 0.200, opacity: 1.000)
        } else if type == "Fairy" {
            return Color(red: 0.969, green: 0.706, blue: 0.969, opacity: 1.000)
        } else if type == "Fighting" {
            return Color(red: 0.655, green: 0.318, blue: 0.224, opacity: 1.000)
        } else if type == "Fire" {
            return Color(red: 0.969, green: 0.322, blue: 0.192, opacity: 1.000)
        } else if type == "Flying" {
            return Color(red: 0.620, green: 0.675, blue: 0.941, opacity: 1.000)
        } else if type == "Ghost" {
            return Color(red: 0.427, green: 0.427, blue: 0.612, opacity: 1.000)
        } else if type == "Grass" {
            return Color(red: 0.478, green: 0.804, blue: 0.318, opacity: 1.000)
        } else if type == "Ground" {
            return Color(red: 0.784, green: 0.659, blue: 0.329, opacity: 1.000)
        } else if type == "Ice" {
            return Color(red: 0.361, green: 0.808, blue: 0.910, opacity: 1.000)
        } else if type == "Normal" {
            return Color(red: 0.569, green: 0.545, blue: 0.498, opacity: 1.000)
        } else if type == "Poison" {
            return Color(red: 0.694, green: 0.361, blue: 0.639, opacity: 1.000)
        } else if type == "Psychic" {
            return Color(red: 0.859, green: 0.451, blue: 0.600, opacity: 1.000)
        } else if type == "Rock" {
            return Color(red: 0.733, green: 0.639, blue: 0.345, opacity: 1.000)
        } else if type == "Steel" {
            return Color(red: 0.678, green: 0.678, blue: 0.780, opacity: 1.000)
        } else if type == "Water" {
            return Color(red: 0.235, green: 0.561, blue: 0.894, opacity: 1.000)
        } else if type == "Shadow" {
            return Color(red: 0.251, green: 0.196, blue: 0.275, opacity: 1.000)
        } else {
            return Color.white
        }
    }
}
//
//struct DetailHeaderView_Previews: PreviewProvider {
//    var pokemonList:  [Pokemon] = Bundle.main.decodeCSV("pokemon.csv")
//    
//    static var previews: some View {
//        DetailHeaderView(pkmn: pokemonList[1])
//    }
//}
