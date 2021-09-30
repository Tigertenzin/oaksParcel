//
//  PrivacyPolicyView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/13/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

struct PrivacyPolicyView: View {
    
    @EnvironmentObject var selectedTheme: UserTheme
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                VStack{
                    Text("Personal Data")
                        .font(.system(.title2, design: .rounded))
                        .bold()
                        .foregroundColor(selectedTheme.themeColor)
                    
                    Text("We don't collect anything  Everything you save or create is stored locally and all processing is done on-device")
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.top)
                .padding(.horizontal)
                .padding(.bottom)
                
                VStack {
                    Text("Any Questions? ")
                        .font(.system(.title2, design: .rounded))
                        .bold()
                        .foregroundColor(selectedTheme.themeColor)
                    
                    Text("Please don't hisitate to contact us about any queries you may have, data related or ortherwise. We're always happy to help. ")
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.bottom)
                
            }
        }
        .navigationBarTitle("Privacy Policy")
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
