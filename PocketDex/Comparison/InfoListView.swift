//
//  InfoListVoew.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/13/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct InfoListView: View {
    var pokemonList:  [Pokemon]
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    var body: some View {
            
        NavigationLink(destination: AboutView(pokemonList: pokemonList)) {
            HStack{
                Image(systemName: "info.circle")
                Text("About the app")
            }
        }
        
        NavigationLink(destination: WhatsNewView(pokemonList: pokemonList)) {
            HStack{
                Text("What's New")
            }
        }
        
        NavigationLink(destination: PrivacyPolicyView()) {
            Text("Privacy Policy")
        }
        
        NavigationLink(destination: PrivacyPolicyView()) {
            Text("Terms of Use")
        }
    }
}
