//
//  ItemView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/1/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct ItemView: View {
    var itemList:  [Item]
    var itemProseList:  [ItemProse]
    
    enum SortType: String, CaseIterable {
        case number, name
    }
    
    enum OrderType: String, CaseIterable {
        case forward, backward
    }
    
    @State private var showSheetView = false
    @State private var searchItemText: String = ""
    @State var sorting: SortType
    @State var order: OrderType
    @State var genFilter: Int = 1
    @State var showingGenFilter = false
    @State var showingConquestFilter = false
    @State var inclusiveGenFilter = false
    
    @EnvironmentObject var selectedTheme: UserTheme
    
    var sortedItemList: [Item] {
        switch sorting {
        case .number:
            return itemList.sorted{$0.id < $1.id}
        case .name :
            return itemList.sorted{$0.wrappedName < $1.wrappedName}
        }
    }
    
    var orderedItemList: [Item] {
        switch order {
        case .forward:
            return sortedItemList
        case .backward:
            return sortedItemList.reversed()
        }
        
    }
    
    var body: some View {
        VStack{
            SearchBar(text: $searchItemText)
                .padding(.horizontal, 4)
            
            List(orderedItemList.filter{
                self.searchItemText.isEmpty ? true : $0.identifier.contains(self.searchItemText) }) { item in
                    Section {
                        NavigationLink(destination: ItemDetailView(itemProseList: itemProseList, item: item)) {
                            if selectedTheme.showSprites {
                                Image(item.imgName)
                                    .interpolation(.none)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                            }
                            VStack(alignment: .leading) {
                                Text("\(item.wrappedName)")
                                Text("\(item.category.pocketName)")
                                    .font(.caption)
                            }
                        }
                    }
            }
            .id(UUID())
        }
        .navigationBarTitle("Item List")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.showSheetView.toggle()
                }) {
                    Label("Filter List", systemImage: "arrow.up.arrow.down.circle.fill")
                }
            }
        }
        .sheet( isPresented: self.$showSheetView) {
            NavigationView {
                 Form {
                    Section(header: Text("Order...")) {
                        Picker(selection: self.$order, label: Text("Ordering: ")) {
                            ForEach(OrderType.allCases, id: \.self) {
                                Text("\($0.rawValue)")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                        
                    Section(header: Text("Sort by...")) {
                        Picker(selection: self.$sorting, label: Text("Choose to sort by: ")) {
                            ForEach(SortType.allCases, id: \.self) {
                                Text("\($0.rawValue)")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Section(header: Text("Defaults")) {
                        Button(action: {
                            self.order = OrderType.forward
                            self.sorting = SortType.number
                            self.showingGenFilter = false
                            self.inclusiveGenFilter = false
                            self.showSheetView = false
                        }) {
                            HStack {
                                Spacer()
                                Text("Set to default")
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            .padding()
                        }
                    }
                 }
                 .navigationBarTitle(Text("Sort and Filter"), displayMode: .inline)
                 .toolbar {
                     ToolbarItem(placement: .navigationBarTrailing) {
                         Button(action: {
                            self.showSheetView = false
                         }) {
                            Text("Done").bold()
                         }
                     }
                 }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
