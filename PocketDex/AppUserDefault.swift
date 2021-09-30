//
//  AppUserDefault.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/15/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

public class AppUserDefaults: ObservableObject{
    public static let shared = AppUserDefaults()
    
    @AppStorage("is_subscribed")
    public var isSubscribed: Bool = false
    
    @AppStorage("number_of_launch")
    public var numberOfLaunch = 0
}
