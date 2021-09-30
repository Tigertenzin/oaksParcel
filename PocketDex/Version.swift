//
//  Version.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/27/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class UserVersion: ObservableObject {
    @Published var versionOrder: Int {
        didSet {
            UserDefaults.standard.set(versionOrder, forKey: "versionOrder")
        }
    }
    
    @Published var noSearchExact: Bool {
        didSet {
            UserDefaults.standard.set(noSearchExact, forKey: "noSearchExact")
        }
    }
    
    public var versionNames = ["Red & Blue",
                               "Yellow",
                               "Gold & Silver",
                               "Crystal",
                               "Ruby & Sapphire",
                               "Emerald",
                               "Colosseum",
                               "XD",
                               "FireRed & LeafGreen",
                               "Diamond & Pearl",
                               "Platinum",
                               "HeartGold & SoulSilver",
                               "Black & White",
                               "Black 2 & White 2",
                               "X & Y",
                               "Omega Ruby & Alpha Sapphire",
                               "Sun & Moon",
                               "Ultra Sun & Ultra Moon"]
    public var versionGens = [1, 1, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 7, 7]
    
    
    var versionName: String {
        return versionNames[versionOrder]
    }
    var versionGen: Int {
        return versionGens[versionOrder]
    }
    
    init(versionName: String, versionGen: Int, versionOrder: Int) {
        self.versionOrder = UserDefaults.standard.object(forKey: "versionOrder") as? Int ?? 16
        self.noSearchExact = UserDefaults.standard.object(forKey: "noSearchExact") as? Bool ?? false
    }
}


//var possibleVersion: [UserVersion] {
//    var tempList = [UserVersion]()
//    tempList.append(UserVersion(versionName: "Red & Blue", versionGen: 1, versionOrder: 1))
//    tempList.append(UserVersion(versionName: "Yellow", versionGen: 1, versionOrder: 2))
//    tempList.append(UserVersion(versionName: "Gold & Silver", versionGen: 2, versionOrder: 3))
//    tempList.append(UserVersion(versionName: "Crystal", versionGen: 2, versionOrder: 4))
//    tempList.append(UserVersion(versionName: "Ruby & Sapphire", versionGen: 3, versionOrder: 5))
//    tempList.append(UserVersion(versionName: "Emerald", versionGen: 3, versionOrder: 6))
//    tempList.append(UserVersion(versionName: "Fire Red & Leaf Green", versionGen: 3, versionOrder: 9))
//    tempList.append(UserVersion(versionName: "Diamond & Pearl", versionGen: 4, versionOrder: 10))
//    tempList.append(UserVersion(versionName: "Platinum", versionGen: 4, versionOrder: 11))
//    tempList.append(UserVersion(versionName: "Heart Gold & Soul Silver", versionGen: 4, versionOrder: 12))
//    tempList.append(UserVersion(versionName: "Black & White", versionGen: 5, versionOrder: 13))
//    tempList.append(UserVersion(versionName: "Black 2 & White 2", versionGen: 5, versionOrder: 14))
//    tempList.append(UserVersion(versionName: "X & Y", versionGen: 6, versionOrder: 15))
//    tempList.append(UserVersion(versionName: "Omega Ruby & Alpha Sapphire", versionGen: 6, versionOrder: 16))
//    tempList.append(UserVersion(versionName: "Sun & Moon", versionGen: 7, versionOrder: 17))
//    tempList.append(UserVersion(versionName: "Ultra Sun & Ultra Moon", versionGen: 7, versionOrder: 18))
//    return tempList
//}

