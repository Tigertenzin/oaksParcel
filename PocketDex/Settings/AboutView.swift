//
//  AboutView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/14/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var pokemonList:  [Pokemon]
    @EnvironmentObject var selectedTheme: UserTheme
    
    let columns = [
        GridItem(.adaptive(minimum: 50))
    ]
    
    var body: some View {
        ScrollView(.vertical) {
            ZStack(alignment: .top) {
                if selectedTheme.showSprites {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(Array(pokemonList[0...806].shuffled()), id: \.self) { item in
                            Image(item.imgName)
                                .opacity(0.3)
                        }
                    }
                    .padding(.horizontal)
                }
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        HStack{
                            Text("Oak's Parcel")
                                .font(.system(.title2, design: .rounded))
                                .bold()
                                .foregroundColor(self.selectedTheme.themeColor)
                            Spacer()
                        }
                        
                        Text("Thank you for donwloading Oak's Parcel. I created this app primarily as a tool to learn SwiftUI, but also in order to bring a modern iOS experience to our Pokemon needs.")
                            .lineLimit(40)
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(.top)
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                    HStack{
                        Spacer()
                        Button(action: {
                            if let url = URL(string: "https://thomastenzin.wordpress.com") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack{
                                Image(systemName: "globe")
                                Text("Website")
                            }
                            .padding()
                                .foregroundColor(.white)
                                .background(self.selectedTheme.themeColor)
                                .cornerRadius(40)
                        }
                        
                        Button(action: {
                            if let url = URL(string: "https://twitter.com/tiger_tenzin") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack{
                                Image(systemName: "person.circle")
                                Text("Twitter")
                            }
                            .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(40)
                        }
                        
                        Spacer()
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Credits & Thanks")
                                .font(.system(.title2, design: .rounded))
                                .bold()
                                .foregroundColor(self.selectedTheme.themeColor)
                            
                            Spacer()
                        }
                        
                        Text("This app uses data and sprites from the Pokemon series of video games. Some terminology from the Pokemon franchise is also necessarily used within the software itself. This is all the intellectual property of Nintendo, Creatures, inc., and GAME FREAK, inc. and is protected by various copyrights and trademarks. The author believes that the use of this intellectual property for a fan reference is covered by fair use and that the software is significantly impaired without said property included. ")
                            .padding(.bottom)
                        
                        
                        Text("Veekun by Eevee")
                            .font(.system(.headline, design: .rounded))
                            .foregroundColor(self.selectedTheme.themeColor)
                        
                        Text("They curate the data and the sprites/images which I use for the app. Without them, this app would have taken much longer to make.")
                        
                        Button(action: {
                            if let url = URL(string: "https://veekun.com") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Text("https://veekun.com")
                        }
                        .padding(.bottom)
                        
                        
                        Text("CodableCSV")
                            .font(.system(.headline, design: .rounded))
                            .foregroundColor(self.selectedTheme.themeColor)
                        
                        Button(action: {
                            if let url = URL(string: "https://github.com/dehesa/CodableCSV") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Text("https://github.com/dehesa/CodableCSV")
                        }
                        .padding(.bottom)
                        
                        VStack{
                            Text("Parma")
                                .font(.system(.headline, design: .rounded))
                                .foregroundColor(self.selectedTheme.themeColor)
                            
                            Button(action: {
                                if let url = URL(string: "https://github.com/dasautoooo/Parma") {
                                    UIApplication.shared.open(url)
                                }
                            }) {
                                Text("https://github.com/dasautoooo/Parma")
                            }
                            .padding(.bottom)
                        }
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                }
            }
            
        }
        .navigationBarTitle("About")
    }
}
