//
//  removeMechanicText.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/5/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation

func removeMechanic(input: String) -> String {
    var adding = true
    var outputString = ""
    var tempStr = ""
    var mechanicsArray = [String]()
    var mechAddingIndex = 0
    
    // create a temp string
    for i in input {
        if i == "[" {
            adding = false
        } else if i == "]" {
            adding = true
        } else if i == "{" {
            adding = false
        } else if i == "}" {
            adding = true
        }
        
        if adding == false {
            tempStr = tempStr + String(i)
        }
    }
    
    for i in tempStr.components(separatedBy: "[") {
        if i.contains("stat-modifier") {
            mechanicsArray.append(i.components(separatedBy: "{")[0])
        } else if i.contains("{") {
            mechanicsArray.append(i.components(separatedBy: "{")[1].components(separatedBy: ":")[1])
        }
    }
    
    for i in input {
        if i == "[" {
            adding = false
        } else if i == "}" {
            adding = true
            outputString = outputString + String(mechanicsArray[mechAddingIndex])
            mechAddingIndex = mechAddingIndex + 1
        } else {
            if adding {
                outputString = outputString + String(i)
            }
        }
    }
    
    return outputString
}
