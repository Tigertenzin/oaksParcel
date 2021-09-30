//
//  SettingsParentView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/21/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct SettingsParentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var selectedTheme: UserTheme
    @EnvironmentObject var selectedVersion: UserVersion
    @EnvironmentObject var iconSettings : IconNames
    
    var pokemonList: [Pokemon]
    
    var body: some View {
        NavigationView {
            SettingsView(pokemonList: pokemonList)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                        }
                    }
                }
            Text("Choose an option on the left. ")
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

