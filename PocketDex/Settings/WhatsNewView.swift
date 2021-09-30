//
//  WhatsNewView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/23/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI
import Parma

struct WhatsNewView: View {
    var pokemonList:  [Pokemon]
    @EnvironmentObject var selectedTheme: UserTheme
    
    let columns = [
        GridItem(.adaptive(minimum: 50))
    ]
    
    var changelog: String {
        if let filepath = Bundle.main.path(forResource: "changelog", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                return contents
            } catch {
                print("file not loaded")
            }
        } else {
            // example.txt not found!
            print("file not found")
            return " "
        }
        return " "
    }
    
    
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
                    Parma(changelog, render: MyRender())
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.top)
                .padding(.horizontal)
                
            }
            
        }
        .navigationBarTitle("What's New")
    }
}


struct MyRender: ParmaRenderable {
    func heading(level: HeadingLevel?, textView: Text) -> Text {
        switch level {
        case .one:
            return textView.font(.system(.largeTitle, design: .rounded)).bold()
        case .two:
            return textView.font(.system(.title, design: .rounded)).bold()
        case .three:
            return textView.font(.system(.title2, design: .rounded)).bold()
        default:
            return textView.font(.system(.title3)).bold()
        }
    }
    
    func headingBlock(level: HeadingLevel?, view: AnyView) -> AnyView {
        switch level {
        case .one, .two:
            return AnyView(
                VStack(alignment: .leading, spacing: 2) {
                    view
                        .padding(.top, 4)
                    Rectangle()
                        .foregroundColor(.pink)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 1, alignment: .center)
                        .padding(.bottom, 8)
                }
            )
        default:
            return AnyView(view.padding(.bottom, 4))
        }
    }
    
    func listItem(view: AnyView) -> AnyView {
        let bullet = "•"
        return AnyView(
            HStack(alignment: .top, spacing: 8) {
                Text(bullet)
                view.fixedSize(horizontal: false, vertical: true)
            }
            .padding(.leading, 4)
        )
    }
}
