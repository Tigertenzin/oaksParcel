//
//  TeamView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/17/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct TeamListView: View {
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
    @State private var showingAddTeam = false
    
    @FetchRequest(entity: Team_1.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Team_1.name, ascending: true)]) var allTeams: FetchedResults<Team_1>
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var selectedTheme: UserTheme
    
    var body: some View {
        List {
            ForEach(allTeams, id: \.id) { team in
                NavigationLink(destination: TeamDetailView(pokemonList: pokemonList,
                                                           pokemonFormsList: pokemonFormsList,
                                                           pokemonTypeList: pokemonTypeList,
                                                           moveList: moveList, 
                                                           moveEffectList: moveEffectList,
                                                           typeList: typeList,
                                                           abilityList: abilityList,
                                                           abilityProseList: abilityProseList,
                                                           pokemonAbilitiesList: pokemonAbilitiesList,
                                                           itemList: itemList,
                                                           pokemonStatList: pokemonStatList,
                                                           team: team)) {
                    TeamCardView(team: team, pokemonList: pokemonList, setList: [team.set1, team.set2, team.set3, team.set4, team.set5, team.set6])
                        .padding(.horizontal)
                }
            }
            .onDelete(perform: deleteTeams)
        }
        .navigationBarTitle("Team Builder")
        .listStyle(InsetGroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
        .navigationBarItems(trailing:
            HStack{
                Menu {
                    Button(action: {
                        self.showingAddTeam.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Team")
                    }
                    
                    EditButton()
                    
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .imageScale(.large)
                }
            }
        )
        .sheet(isPresented: $showingAddTeam) {
            AddTeamView(pokemonList: pokemonList)
                .environment(\.managedObjectContext, self.moc)
                .accentColor(selectedTheme.themeColor)
        }
    }

    func deleteTeams(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our fetch request
            let team = allTeams[offset]

            // delete it from the context
            moc.delete(team)
        }

        // save the context
        try? moc.save()
    }
}
