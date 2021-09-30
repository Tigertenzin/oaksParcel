//
//  ItemDetailView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/1/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct ItemDetailView: View {
    var itemProseList:  [ItemProse]
    let item: Item
    let languageID = 9
    
    @EnvironmentObject var selectedTheme: UserTheme
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: FavPkmn.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \FavPkmn.pkmnID, ascending: true)]) var allFavPkmn: FetchedResults<FavPkmn>
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                
                HStack{
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Bag Pocket")
                                .font(.system(.title2, design: .rounded))
                                .bold()
                                .fixedSize(horizontal: true, vertical: false)
                            Spacer()
                        }
                        Text(self.item.category.pocketName)
                            .fixedSize(horizontal: true, vertical: false)
                    }
                    .padding()
                    .frame(width: geo.size.width/2)
                    .fixedSize(horizontal: false, vertical: true)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    
                    VStack(alignment: .leading) {
                        HStack{
                            Text("Category")
                                .font(.system(.title2, design: .rounded))
                                .bold()
                                .fixedSize(horizontal: true, vertical: false)
                            Spacer()
                        }
                        Text(self.item.categoryProse.name)
                            .fixedSize(horizontal: true, vertical: false)
                    }
                    .padding()
                    .frame(width: geo.size.width/2)
                    .fixedSize(horizontal: false, vertical: true)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                }
                .padding(.top)
                
                VStack(alignment: .leading) {
                    HStack{
                        Text("Short Effect")
                            .font(.system(.title2, design: .rounded))
                            .bold()
                            .layoutPriority(1)
                        Spacer()
                    }
                    Text(self.findItemProse(itemID: self.item.id, languagaeID: self.languageID, itemProseList: self.itemProseList).short_effect)
                        .lineLimit(10)
                }
                .padding()
                .frame(width: geo.size.width)
                .fixedSize(horizontal: false, vertical: true)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
                
                VStack(alignment: .leading) {
                    HStack{
                        Text("Full Effect Description")
                            .font(.system(.title2, design: .rounded))
                            .bold()
                            .layoutPriority(1)
                        Spacer()
                    }
                    Text(removeMechanic(input: self.findItemProse(itemID: self.item.id, languagaeID: self.languageID, itemProseList: self.itemProseList).wrappedEffect))
                        .lineLimit(40)
                }
                .padding()
                .frame(width: geo.size.width)
                .fixedSize(horizontal: false, vertical: true)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
                
                if selectedTheme.showSprites {
                    VStack(alignment: .leading) {
                        HStack{
                            Text("In-Game Image/Sprite")
                                .font(.system(.title2, design: .rounded))
                                .bold()
                                .layoutPriority(1)
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            Image(item.imgName)
                                .interpolation(.none)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                            Spacer()
                        }
                    }
                    .padding()
                    .frame(width: geo.size.width)
                    .fixedSize(horizontal: false, vertical: true)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                }
            }
        }
        .navigationBarTitle("\(item.wrappedName)")
        .navigationBarItems(trailing:
            Menu {
                if allFavPkmn.contains{$0.pkmnID == item.id && $0.type==4} {
                    Button(action: {
                         print("already saved")
                    }) {
                        Text("Added to favorites")
                        Image(systemName: "star.fill")
                    }
                } else {
                    Button(action: {
                        let newFavPkmn = FavPkmn(context: self.moc)
                        newFavPkmn.id = UUID()
                        newFavPkmn.pkmnID = Int16(item.id)
                        newFavPkmn.type = 4 // Type 2 = Move
                        try? self.moc.save()
                    }) {
                        Text("Add to favorites")
                        Image(systemName: "star")
                    }
                }
            } label: {
                Image(systemName: "ellipsis.circle")
                    .imageScale(.large)
            }
        )
        .padding(.horizontal)
    }
    
    
    func findItemProse(itemID: Int, languagaeID: Int, itemProseList: [ItemProse]) -> ItemProse {
        if let i = itemProseList.firstIndex(where: {$0.item_id == itemID}) {
            if itemProseList[i].local_language_id == languagaeID{
                return itemProseList[i]
            } else {
                return ItemProse()
            }
        }
        return ItemProse()
    }
}

