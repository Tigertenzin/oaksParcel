//
//  Pokemon_Forms.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/15/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation

struct Pokemon_Forms: Codable, Identifiable, Hashable {
    let id: Int
    let identifier: String
    let form_identifier: String?
    let pokemon_id: Int
    let is_default: Int
    let is_battle_only: Int
    let is_mega: Int
    let form_order: Int
    
    var wrappedform_identifier: String {
        return form_identifier?.replacingOccurrences(of: "-", with: " ").capitalized ?? "Original"
    }
}

