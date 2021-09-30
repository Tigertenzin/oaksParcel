//
//  DetailFormsView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/15/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct DetailFormsView: View {
    
    var otherForms: [Pokemon]
    var otherFormsDetails: [Pokemon_Forms]
    
    @Binding var pkmn: Pokemon
    @Binding var showingForms: Bool
    
    @EnvironmentObject var selectedTheme: UserTheme
    
    var body: some View {
        VStack{
            HStack{
                Text("Forms")
                    .font(.system(.title2, design: .rounded))
                    .bold()
                    .multilineTextAlignment(.leading)
                Spacer()
                Button(action: {
                    self.showingForms.toggle()
                }) {
                    if self.showingForms {
                        Image(systemName: "chevron.down.circle").imageScale(.large)
                    }
                    if self.showingForms==false {
                        Image(systemName: "chevron.left.circle").imageScale(.large)
                    }
                }.hoverEffect()
            }
            if self.showingForms {
                ScrollView(.horizontal) {
                    HStack{
                        ForEach(otherFormsDetails, id: \.self) {
                            DetailFormSingleView(pkmn: pkmn, pkmnForm: $0)
                        }
                    }
                }
            }
        }
    }
}

struct DetailFormSingleView: View {
    let pkmn: Pokemon
    let pkmnForm: Pokemon_Forms
    
    @EnvironmentObject var selectedTheme: UserTheme
    
    var body: some View {
        VStack{
            if selectedTheme.showSprites {
                if pkmnForm.form_identifier == nil {
                    Image(String(pkmn.id))
                        .interpolation(.none)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 64, height: 64)
                } else {
                    Image(String(pkmn.id)+"-"+String(pkmnForm.form_identifier ?? ""))
                        .interpolation(.none)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 64, height: 64)
                }
            }
            Text(pkmnForm.wrappedform_identifier)
                .font(.system(.footnote, design: .rounded))
                .bold()
                .fixedSize(horizontal: true, vertical: true)
                .padding(.horizontal)
                .frame(height: 24)
                .padding(.bottom)
        }
        .background(Color(UIColor.tertiarySystemFill))
        .cornerRadius(8)
    }
}
