//
//  SettingsView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/27/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var selectedTheme: UserTheme
    @EnvironmentObject var selectedVersion: UserVersion
    @EnvironmentObject var iconSettings : IconNames
    @Environment(\.presentationMode) var presentationMode
    
    var pokemonList: [Pokemon]
    
    var body: some View {
        List {
            Section(header: Text("Appearance")) {
                Picker(selection: $selectedTheme.themeIndex, label: Text("Theme Name")) {
                    ForEach(0...7, id: \.self) { themeIndex in
                        HStack{
                            RoundedRectangle(cornerRadius: 4, style: .continuous)
                                .fill(self.selectedTheme.themeColors[themeIndex])
                                .frame(width: 16, height: 16)
                            Text(self.selectedTheme.themeNames[themeIndex])
                        }
                    }
                }
                
                Toggle(isOn: $selectedTheme.showSprites) {
                    Text("Show Pokemon Sprites")
                }
            }
            
            Section(header: Text("Data"), footer: Text("When searching for Pokemon by their Pokedex number, either match the exact number (On) or their Pokedex number contains the searched number (Off).")) {
                Picker(selection: $selectedVersion.versionOrder, label: Text("Version")) {
                    ForEach(0...17, id: \.self) { versionOrder in
                        Text(self.selectedVersion.versionNames[versionOrder])
                    }
                }
                .animation(.interactiveSpring())
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                
                Toggle(isOn: $selectedVersion.noSearchExact) {
                    Text("Search by Exact Number")
                }
            }
            
//            Section(header: Text("Language Settings")) {
//                Picker(selection: $selectedTheme.displayLanguageID, label: Text("Language")) {
//                    ForEach(0...8, id: \.self) { languageID in
//                        Text(self.selectedTheme.languageNames[languageID])
//                    }
//                }
//                .animation(.interactiveSpring())
//                .listStyle(GroupedListStyle())
//                .environment(\.horizontalSizeClass, .regular)
//            }

            
            Section(header: Text("App Icon")) {
                Picker(selection: $iconSettings.currentIndex, label: Text("Icons")) {
                    ForEach(0..<iconSettings.iconNames.count) { index in
                        HStack{
                            Image(uiImage: UIImage(named: self.iconSettings.iconNames[index] ?? "Ruby (Light)") ?? UIImage())
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 50)
                                .cornerRadius(10)
                            
                            Text(self.iconSettings.iconNames[index] ?? "Ruby (Light)")
                                .frame(minWidth: 100, alignment: .leading)
                        }
                    }
                }.onReceive([self.iconSettings.currentIndex].publisher.first()) { (value) in
                    
                    let index = self.iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                    
                    if index != value{
                        UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[value]){ error in
                            if let error = error {
                                print("Change app icons: \(error.localizedDescription)")
                            } else {
                                print("Change app icons: Success!")
                            }
                        }
                    }
                    
                }
            }
            
            Section(header: Text("Support")) {
                NavigationLink(destination: PurchaseView()) {
                    HStack{
                        Image(systemName: "dollarsign.circle")
                            .foregroundColor(selectedTheme.themeColor)
                        Text("Support the Developer")
                    }
                }
            }
            
            Section(header: Text("About")) {
                InfoListView(pokemonList: pokemonList)
                FeedbackView()
            }
        }
        .animation(.interactiveSpring())
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Settings")

    }
}


struct VersionListView: View{
    @EnvironmentObject var selectedVersion: UserVersion
    var possibleVersion: [UserVersion] {
        var tempList = [UserVersion]()
        tempList.append(UserVersion(versionName: "Red & Blue", versionGen: 1, versionOrder: 1))
        tempList.append(UserVersion(versionName: "Yellow", versionGen: 1, versionOrder: 2))
        tempList.append(UserVersion(versionName: "Gold & Silver", versionGen: 2, versionOrder: 3))
        tempList.append(UserVersion(versionName: "Crystal", versionGen: 2, versionOrder: 4))
        tempList.append(UserVersion(versionName: "Ruby & Sapphire", versionGen: 3, versionOrder: 5))
        tempList.append(UserVersion(versionName: "Emerald", versionGen: 3, versionOrder: 6))
        tempList.append(UserVersion(versionName: "Fire Red & Leaf Green", versionGen: 3, versionOrder: 9))
        tempList.append(UserVersion(versionName: "Diamond & Pearl", versionGen: 4, versionOrder: 10))
        tempList.append(UserVersion(versionName: "Platinum", versionGen: 4, versionOrder: 11))
        tempList.append(UserVersion(versionName: "Heart Gold & Soul Silver", versionGen: 4, versionOrder: 12))
        tempList.append(UserVersion(versionName: "Black & White", versionGen: 5, versionOrder: 13))
        tempList.append(UserVersion(versionName: "Black 2 & White 2", versionGen: 5, versionOrder: 14))
        tempList.append(UserVersion(versionName: "X & Y", versionGen: 6, versionOrder: 15))
        tempList.append(UserVersion(versionName: "Omega Ruby & Alpha Sapphire", versionGen: 6, versionOrder: 16))
        tempList.append(UserVersion(versionName: "Sun & Moon", versionGen: 7, versionOrder: 17))
        tempList.append(UserVersion(versionName: "Ultra Sun & Ultra Moon", versionGen: 7, versionOrder: 18))
        return tempList
    }
    
    var body: some View {
        List {
            ForEach(possibleVersion, id: \.versionOrder) { version in
                Button(action: {
                    self.selectedVersion.versionOrder = version.versionOrder
                }) {
                    Text(version.versionName)
                }
            }
        }
        .animation(.interactiveSpring())
        .listStyle(GroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
        .navigationBarTitle("Themes", displayMode: .inline)
    }
}
