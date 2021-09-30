//
//  Item.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/1/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation

struct Item: Codable, Identifiable {
    
    let id: Int
    let identifier: String
    let category_id: Int
    let cost: Int
    
    let itemCategoryList: [ItemCategory] = Bundle.main.decodeCSV("item_categories.csv")
    let itemCategoryProseList: [ItemCategoryProse] = Bundle.main.decodeCSV("item_category_prose.csv")
    
    var wrappedName: String {
        return identifier.replacingOccurrences(of: "-", with: " ").capitalized
    }
    
    var imgName: String {
        return identifier
    }
    
    var category: ItemCategory {
        if let i = itemCategoryList.firstIndex(where: {$0.id == category_id}) {
            return itemCategoryList[i]
        }
        return ItemCategory()
    }
    
    var categoryProse: ItemCategoryProse {
        if let i = itemCategoryProseList.firstIndex(where: {$0.item_category_id == category.id}) {
            return itemCategoryProseList[i]
        }
        return ItemCategoryProse()
    }
}

struct ItemProse: Codable, Identifiable {
    let id = UUID()
    
    let item_id: Int
    let local_language_id: Int
    
    let short_effect: String
    let effect: String
    
    var wrappedEffect: String {
        var temp = effect.components(separatedBy: "\n")
        for itemTemp in 0..<temp.count {
            temp[itemTemp] = temp[itemTemp].replacingOccurrences(of: "  ", with: "")
            temp[itemTemp] = temp[itemTemp].replacingOccurrences(of: ": ", with: "")
            if temp[itemTemp] == "Used on a party Pokémon" {
               temp[itemTemp] = temp[itemTemp] + ": "
            } else if temp[itemTemp] == "Used in battle" {
               temp[itemTemp] = temp[itemTemp] + ": "
            } else if temp[itemTemp] == "Held" {
               temp[itemTemp] = temp[itemTemp] + ": "
            } else if temp[itemTemp] == "Used outside of battle" {
               temp[itemTemp] = temp[itemTemp] + ": "
            } else if temp[itemTemp] == "Held in battle" {
               temp[itemTemp] = temp[itemTemp] + ": "
            }
        }
        return temp.joined(separator: "\n")
    }
    
    init() {
        item_id = 0
        local_language_id = 9
        short_effect = "N/A"
        effect = "N/A"
    }
}

struct ItemCategory: Codable, Identifiable {
    let id: Int
    let pocket_id: Int
    let identifier: String
    
    var pocketName: String {
        if pocket_id == 1 {
            return "Items"
        } else if pocket_id == 2 {
            return  "Medicine"
        } else if pocket_id == 3 {
            return  "Poke Balls"
        } else if pocket_id == 4 {
            return  "TMs and HMs"
        } else if pocket_id == 5 {
            return  "Berries"
        } else if pocket_id == 6 {
            return  "Mail"
        } else if pocket_id == 7 {
            return  "Battle Items"
        } else if pocket_id == 8 {
            return  "Key Items"
        } else {
            return "N/A"
        }
    }
    
    init() {
        id = 0
        pocket_id = 0
        identifier = "N/A"
    }
}

struct ItemCategoryProse: Codable, Identifiable {
    let id = UUID()
    let item_category_id: Int
    let local_language_id: Int
    let name: String
    
    init() {
        item_category_id = 0
        local_language_id = 9
        name = "N/A"
    }
}
