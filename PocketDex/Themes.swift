//
//  Themes.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 6/28/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class UserTheme: ObservableObject {
    @Published var themeIndex: Int {
        didSet {
            UserDefaults.standard.set(themeIndex, forKey: "themeIndex")
        }
    }
    @Published var displayLanguageID: Int {
        didSet {
            UserDefaults.standard.set(displayLanguageID, forKey: "displayLanguageID")
        }
    }
    @Published var showSprites: Bool {
        didSet {
            UserDefaults.standard.set(showSprites, forKey: "showSprites")
        }
    }
    
    public var themeNames = ["Red", "Blue", "Green", "Yellow", "Sun", "Moon",  "Jigglypuff", "Gray"]
    public var themeColors = [Color.red, Color.blue, Color.green, Color.yellow, Color.orange, Color.purple, Color.pink, Color.gray]
    public var languageNames = ["Japanese", "Official Roomaji", "Korean", "Chinese", "French", "German", "Spanish", "Italian", "English", "Czech", "Japanese (again?)", "Chinese (again?)", "Br"]
    
    var themeName: String {
        return themeNames[themeIndex]
    }
    var themeColor: Color {
        return themeColors[themeIndex]
    }
    
    init(themeIndex: Int) {
        self.themeIndex = UserDefaults.standard.object(forKey: "themeIndex") as? Int ?? 1
        self.displayLanguageID = UserDefaults.standard.object(forKey: "displayLanguageID") as? Int ?? 8
        self.showSprites = UserDefaults.standard.object(forKey: "showSprites") as? Bool ?? false
    }
}
