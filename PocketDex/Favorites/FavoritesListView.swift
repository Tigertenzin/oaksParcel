//
//  FavoritesListView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/15/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct FavoritesListView: View {
    
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
    var itemProseList:  [ItemProse]
    
    @EnvironmentObject var selectedTheme: UserTheme
    @FetchRequest(entity: FavPkmn.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \FavPkmn.type, ascending: true)]) var allFavPkmn: FetchedResults<FavPkmn>
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        List {

            if allFavPkmn.contains { $0.type == 1 } {
                Section(header: Text("Pokemon")) {
                    ForEach(allFavPkmn, id: \.id) { pkmn in
                        if pkmn.type==1 {
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
                                                                   pkmn: pokemonList[Int(pkmn.pkmnID)-1])) {
                                DexViewRow(pkmn: pokemonList[Int(pkmn.pkmnID)-1], pkmnTypeList: getTypes(typeList: self.pokemonTypeList, pkmnID: Int(pkmn.pkmnID)), typeList: typeList)
                            }
                        }
                    }
                    .onDelete(perform: deleteTeams)
                }
            }
            
            if allFavPkmn.contains { $0.type == 2 } {
                Section(header: Text("Moves")) {
                    ForEach(allFavPkmn, id: \.id) { pkmn in
                        if pkmn.type == 2 {
                            NavigationLink(destination: MoveDetailView(pokemonList: pokemonList,
                                                                       pokemonFormsList: pokemonFormsList,
                                                                       pokemonTypeList: pokemonTypeList,
                                                                       moveList: moveList,
                                                                       moveEffectList: moveEffectList,
                                                                       typeList: typeList,
                                                                       abilityList: abilityList,
                                                                       abilityProseList: abilityProseList,
                                                                       pokemonAbilitiesList: pokemonAbilitiesList,
                                                                       itemList: itemList,
                                                                       move: moveList[Int(pkmn.pkmnID)-1])) {
                                HStack {
                                    // Display the pkmn sprite
                                    Text("\(moveList[Int(pkmn.pkmnID)-1].wrappedName)")
                                    
                                    Spacer()

                                    // Display the move's type
                                    ZStack {
                                        Text("\(self.typeList[moveList[Int(pkmn.pkmnID)-1].type_id-1].wrappedName)")
                                    }.frame(width: 56, height: 28).background(typeColor(type: self.typeList[moveList[Int(pkmn.pkmnID)-1].type_id-1].wrappedName)).cornerRadius(6).font(.caption)
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteTeams)
                }
            }
            
            if allFavPkmn.contains { $0.type == 3 } {
                Section(header: Text("Abilities")) {
                    ForEach(allFavPkmn, id: \.id) { pkmn in
                        if pkmn.type == 3 {
                            NavigationLink(destination: AbilityDetailView(pokemonList:pokemonList,
                                                                          pokemonFormsList: pokemonFormsList,
                                                                          pokemonTypeList:pokemonTypeList,
                                                                          moveList:moveList,
                                                                          moveEffectList:moveEffectList,
                                                                          typeList:typeList,
                                                                          abilityList:abilityList,
                                                                          abilityProseList:abilityProseList,
                                                                          pokemonAbilitiesList:pokemonAbilitiesList,
                                                                          itemList: itemList,
                                                                          ability: abilityList[Int(pkmn.pkmnID)-1])) {
                                HStack {
                                    // Display the ability name
                                    Text("\(abilityList[Int(pkmn.pkmnID)-1].wrappedName)")
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteTeams)
                }
            }
            
            if allFavPkmn.contains { $0.type == 4 } {
                Section(header: Text("Items")) {
                    ForEach(allFavPkmn, id: \.id) { pkmn in
                        if pkmn.type == 4 {
                            NavigationLink(destination: ItemDetailView(itemProseList: itemProseList, item: itemList[Int(pkmn.pkmnID)-1])) {
                                if selectedTheme.showSprites {
                                    Image(itemList[Int(pkmn.pkmnID)-1].imgName)
                                        .interpolation(.none)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24, height: 24)
                                }
                                VStack(alignment: .leading) {
                                    Text("\(itemList[Int(pkmn.pkmnID)-1].wrappedName)")
                                    Text("\(itemList[Int(pkmn.pkmnID)-1].category.pocketName)")
                                        .font(.caption)
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteTeams)
                }
            }
            
//            NavigationLink(destination: Text("Stats on Favorites")) {
//                Text("Statistics of Favorites")
//            }
            
            
            
//            Section(header: Text("Moves")) {
//                ForEach(allFavMove, id: \.id) { move in
//                    Text("Favorite: \(move.moveID)")
//                }
//            }
//
//            Section(header: Text("Abilities")) {
//                ForEach(allFavAbil, id: \.id) { abil in
//                    Text("Favorite: \(abil.abilID)")
//                }
//            }
//
//            Section(header: Text("Items")) {
//                ForEach(allFavItem, id: \.id) { item in
//                    Text("Favorite: \(item.itemID)")
//                }
//            }
        }
        .navigationBarTitle("Favorites")
        .listStyle(InsetGroupedListStyle())
        .navigationBarItems(trailing:
            HStack{
                Menu {
//                    Button(action: {
//                        self.showingAddTeam.toggle()
//                    }) {
//                        Image(systemName: "plus.circle.fill")
//                        Text("Add Team")
//                    }
                    
                    EditButton()
                    
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .imageScale(.large)
                }
            }
        )
    }
    
    
    func deleteTeams(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our fetch request
            let pkmn = allFavPkmn[offset]

            // delete it from the context
            moc.delete(pkmn)
        }

        // save the context
        try? moc.save()
    }
}

//struct FavoritesListView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritesListView()
//    }
//}
