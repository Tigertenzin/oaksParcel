//
//  TeamDetailView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/19/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct TeamDetailView: View {
    var pokemonList:  [Pokemon]
    var pokemonFormsList: [Pokemon_Forms]
    var pokemonTypeList:  [PokemonType]
    var moveList:  [Move]
    var moveEffectList:  [MoveEffectProse]
    var typeList:  [Type]
    var abilityList:  [Ability]
    var abilityProseList:  [AbilityProse]
    var pokemonAbilitiesList:  [PokemonAbilities]
    var itemList: [Item]
    var pokemonStatList: [PokemonStat]
    
    @State var team: Team_1
    
    @State private var text = ""
    @State private var showingEditView = false
    @State private var pkmnInDetailView = Pokemon()
    
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var selectedTheme: UserTheme
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {

                NavigationLink(destination: DetailView(pokemonFormsList: pokemonFormsList,
                                                       pokemonTypeList: pokemonTypeList,
                                                       typeList: typeList,
                                                       pokemonList: pokemonList,
                                                       moveList: moveList,
                                                       moveEffectList: moveEffectList,
                                                       abilityList: abilityList,
                                                       abilityProseList: abilityProseList,
                                                       pokemonAbilitiesList: pokemonAbilitiesList,
                                                       itemList: itemList,
//                                                       otherForms: getOtherForms(inputPokemon: self.pokemonList[Int(team.pkmn1ID)-1], pokemonList: pokemonList),
                                                       pkmn: self.pokemonList[Int(team.pkmn1ID)-1])) {
                    TeamDetailButton2(pkmn: self.pokemonList[Int(team.pkmn1ID)-1])
                        .padding(.horizontal)
                        .hoverEffect(.highlight)
                }

                NavigationLink(destination: DetailView(pokemonFormsList: pokemonFormsList,
                                                       pokemonTypeList: pokemonTypeList,
                                                       typeList: typeList,
                                                       pokemonList: pokemonList,
                                                       moveList: moveList,
                                                       moveEffectList: moveEffectList,
                                                       abilityList: abilityList,
                                                       abilityProseList: abilityProseList,
                                                       pokemonAbilitiesList: pokemonAbilitiesList,
                                                       itemList: itemList,
//                                                       otherForms: getOtherForms(inputPokemon: self.pokemonList[Int(team.pkmn2ID)-1], pokemonList: pokemonList),
                                                       pkmn: self.pokemonList[Int(team.pkmn2ID)-1])) {
                    TeamDetailButton2(pkmn: self.pokemonList[Int(team.pkmn2ID)-1])
                        .padding(.horizontal)
                        .hoverEffect(.highlight)
                }

                NavigationLink(destination: DetailView(pokemonFormsList: pokemonFormsList,
                                                       pokemonTypeList: pokemonTypeList,
                                                       typeList: typeList,
                                                       pokemonList: pokemonList,
                                                       moveList: moveList,
                                                       moveEffectList: moveEffectList,
                                                       abilityList: abilityList,
                                                       abilityProseList: abilityProseList,
                                                       pokemonAbilitiesList: pokemonAbilitiesList,
                                                       itemList: itemList,
//                                                       otherForms: getOtherForms(inputPokemon: self.pokemonList[Int(team.pkmn3ID)-1], pokemonList: pokemonList),
                                                       pkmn: self.pokemonList[Int(team.pkmn3ID)-1])) {
                    TeamDetailButton2(pkmn: self.pokemonList[Int(team.pkmn3ID)-1])
                        .padding(.horizontal)
                        .hoverEffect(.highlight)
                }

                NavigationLink(destination: DetailView(pokemonFormsList: pokemonFormsList,
                                                       pokemonTypeList: pokemonTypeList,
                                                       typeList: typeList,
                                                       pokemonList: pokemonList,
                                                       moveList: moveList,
                                                       moveEffectList: moveEffectList,
                                                       abilityList: abilityList,
                                                       abilityProseList: abilityProseList,
                                                       pokemonAbilitiesList: pokemonAbilitiesList,
                                                       itemList: itemList,
//                                                       otherForms: getOtherForms(inputPokemon: self.pokemonList[Int(team.pkmn4ID)-1], pokemonList: pokemonList),
                                                       pkmn: self.pokemonList[Int(team.pkmn4ID)-1])) {
                    TeamDetailButton2(pkmn: self.pokemonList[Int(team.pkmn4ID)-1])
                        .padding(.horizontal)
                        .hoverEffect(.highlight)
                }

                NavigationLink(destination: DetailView(pokemonFormsList: pokemonFormsList,
                                                       pokemonTypeList: pokemonTypeList,
                                                       typeList: typeList,
                                                       pokemonList: pokemonList,
                                                       moveList: moveList,
                                                       moveEffectList: moveEffectList,
                                                       abilityList: abilityList,
                                                       abilityProseList: abilityProseList,
                                                       pokemonAbilitiesList: pokemonAbilitiesList,
                                                       itemList: itemList,
//                                                       otherForms: getOtherForms(inputPokemon: self.pokemonList[Int(team.pkmn5ID)-1], pokemonList: pokemonList),
                                                       pkmn: self.pokemonList[Int(team.pkmn5ID)-1])) {
                    TeamDetailButton2(pkmn: self.pokemonList[Int(team.pkmn5ID)-1])
                        .padding(.horizontal)
                        .hoverEffect(.highlight)
                }

                NavigationLink(destination: DetailView(pokemonFormsList: pokemonFormsList,
                                                       pokemonTypeList: pokemonTypeList,
                                                       typeList: typeList,
                                                       pokemonList: pokemonList,
                                                       moveList: moveList,
                                                       moveEffectList: moveEffectList,
                                                       abilityList: abilityList,
                                                       abilityProseList: abilityProseList,
                                                       pokemonAbilitiesList: pokemonAbilitiesList,
                                                       itemList: itemList, 
//                                                       otherForms: getOtherForms(inputPokemon: self.pokemonList[Int(team.pkmn6ID)-1], pokemonList: pokemonList),
                                                       pkmn: self.pokemonList[Int(team.pkmn6ID)-1])) {
                    TeamDetailButton2(pkmn: self.pokemonList[Int(team.pkmn6ID)-1])
                        .padding(.horizontal)
                        .hoverEffect(.highlight)
                }
                
                VStack(alignment: .leading) {
                    HStack{
                        Text("Notes")
                            .font(.system(.title2, design: .rounded))
                            .bold()
                            .layoutPriority(1)
                        Spacer()
                    }
                    
                    Text(team.note ?? "")
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                .fixedSize(horizontal: false, vertical: true)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.horizontal)
                
                
                CompareComponentView(pokemonTypeList: self.pokemonTypeList,
                                                        typeList: self.typeList,
                                                        pokemonList: self.pokemonList,
                                                        moveList: self.moveList,
                                                        moveEffectList: self.moveEffectList,
                                                        abilityList: self.abilityList,
                                                        abilityProseList: self.abilityProseList,
                                                        pokemonAbilitiesList: self.pokemonAbilitiesList,
                                                        pokemonStatList: self.pokemonStatList,
                                                        comparisonList: [self.pokemonList[Int(team.pkmn1ID)-1], self.pokemonList[Int(team.pkmn2ID)-1], self.pokemonList[Int(team.pkmn3ID)-1], self.pokemonList[Int(team.pkmn4ID)-1], self.pokemonList[Int(team.pkmn5ID)-1], self.pokemonList[Int(team.pkmn6ID)-1]])
                
                VStack{
                    HStack{
                        Text("QR Code")
                            .font(.system(.title2, design: .rounded))
                            .bold()
                        Spacer()
                    }
                    
                    Image(uiImage: generateQRCode(from: "\(String(describing: team.name))\n\(String(describing: team.note))\n\(String(describing: team.versionOrderID))\n\(String(describing:team.pkmn1ID))\n\(String(describing:team.pkmn2ID))\n\(String(describing:team.pkmn3ID))\n\(String(describing:team.pkmn4ID))\n\(String(describing:team.pkmn5ID))\n\(String(describing:team.pkmn6ID))"))
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
                .padding()
                .fixedSize(horizontal: false, vertical: true)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.horizontal)
            }
        }
        .navigationBarTitle(team.name ?? "N/A")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.showingEditView.toggle()
                }) {
                    Text("Edit")
                }
            }
        }
//        .navigationBarItems(
//            trailing: Button("Edit") {
//                self.showingEditView.toggle()
//        })
        .sheet(isPresented: self.$showingEditView) {
            EditTeamView(pokemonList: pokemonList,
                         team: team,
                         name: team.name ?? "Uknown Team Name",
                         note: team.note ?? "",
                         pkmn1: self.pokemonList[Int(team.pkmn1ID)-1],
                         pkmn2: self.pokemonList[Int(team.pkmn2ID)-1],
                         pkmn3: self.pokemonList[Int(team.pkmn3ID)-1],
                         pkmn4: self.pokemonList[Int(team.pkmn4ID)-1],
                         pkmn5: self.pokemonList[Int(team.pkmn5ID)-1],
                         pkmn6: self.pokemonList[Int(team.pkmn6ID)-1],
                         set1: team.set1,
                         set2: team.set2,
                         set3: team.set3,
                         set4: team.set4,
                         set5: team.set5,
                         set6: team.set6,
                         versionOrderID: Int(team.versionOrderID)
            )
            .environment(\.managedObjectContext, self.moc)
            .accentColor(selectedTheme.themeColor)
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}



//@State private var team: Team_1
//
//@State private var name: String
//@State private var note: String
//@State private var pkmn1: Pokemon
//@State private var pkmn2: Pokemon
//@State private var pkmn3: Pokemon
//@State private var pkmn4: Pokemon
//@State private var pkmn5: Pokemon
//@State private var pkmn6: Pokemon
//@State private var versionOrderID: Int
//@State private var searchText : String = ""
