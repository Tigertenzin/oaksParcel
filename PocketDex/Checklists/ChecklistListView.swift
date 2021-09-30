//
//  ChecklistListView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/24/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct ChecklistListView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var selectedTheme: UserTheme
    
    @FetchRequest(entity: Checklist.entity(), sortDescriptors: []) var allLists: FetchedResults<Checklist>
    @State private var showingAddScreen = false
    
    var pokemonList:  [Pokemon]
    
    var body: some View {
        List{
            ForEach(allLists, id: \.self) { checklist in
                NavigationLink(destination: ChecklistDetailView(checklist: checklist,
                                                                pokemonList: pokemonList)) {
                    VStack(alignment: .leading){
                        Text("\(checklist.name ?? "Unknown")")
                            .font(.headline)
                        HStack{
                            Text("\(checklist.type ?? "Unknown Type") - ")
                                .font(.caption)
                            Text("\(checklist.checklist?.filter({ $0 == true }).count ?? 0)/\(checklist.checklist?.count ?? 0)")
                                .font(.caption)
                            Spacer()
                        }
                    }
                }
            }
            .onDelete(perform: deleteList)
        }
        .animation(.interactiveSpring())
        .listStyle(InsetGroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
        .navigationBarTitle("Checklists")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.showingAddScreen.toggle()
                }) {
                    Label("Add a Checklist", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddScreen) {
            AddChecklistView()
                .environment(\.managedObjectContext, self.moc)
                .accentColor(selectedTheme.themeColor)
        }
    }

    func deleteList(at offsets: IndexSet) {
        for offset in offsets {
            let list = allLists[offset]
            moc.delete(list)
        }
        try? moc.save()
    }
}
