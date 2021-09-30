//
//  typeColor.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/6/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation
import SwiftUI

func typeColor(type: String) -> Color {
    // Returns the type for a corresponding color.
    if type == "Bug" {
        return Color(red: 0.682, green: 0.737, blue: 0.129, opacity: 1.000)
    } else if type == "Dark" {
        return Color(red: 0.443, green: 0.345, blue: 0.286, opacity: 1.000)
    } else if type == "Dragon" {
        return Color(red: 0.463, green: 0.373, blue: 0.839, opacity: 1.000)
    } else if type == "Electric" {
        return Color(red: 0.988, green: 0.769, blue: 0.200, opacity: 1.000)
    } else if type == "Fairy" {
        return Color(red: 0.969, green: 0.706, blue: 0.969, opacity: 1.000)
    } else if type == "Fighting" {
        return Color(red: 0.655, green: 0.318, blue: 0.224, opacity: 1.000)
    } else if type == "Fire" {
        return Color(red: 0.969, green: 0.322, blue: 0.192, opacity: 1.000)
    } else if type == "Flying" {
        return Color(red: 0.620, green: 0.675, blue: 0.941, opacity: 1.000)
    } else if type == "Ghost" {
        return Color(red: 0.427, green: 0.427, blue: 0.612, opacity: 1.000)
    } else if type == "Grass" {
        return Color(red: 0.478, green: 0.804, blue: 0.318, opacity: 1.000)
    } else if type == "Ground" {
        return Color(red: 0.784, green: 0.659, blue: 0.329, opacity: 1.000)
    } else if type == "Ice" {
        return Color(red: 0.361, green: 0.808, blue: 0.910, opacity: 1.000)
    } else if type == "Normal" {
        return Color(red: 0.569, green: 0.545, blue: 0.498, opacity: 1.000)
    } else if type == "Poison" {
        return Color(red: 0.694, green: 0.361, blue: 0.639, opacity: 1.000)
    } else if type == "Psychic" {
        return Color(red: 0.859, green: 0.451, blue: 0.600, opacity: 1.000)
    } else if type == "Rock" {
        return Color(red: 0.733, green: 0.639, blue: 0.345, opacity: 1.000)
    } else if type == "Steel" {
        return Color(red: 0.678, green: 0.678, blue: 0.780, opacity: 1.000)
    } else if type == "Water" {
        return Color(red: 0.235, green: 0.561, blue: 0.894, opacity: 1.000)
    } else if type == "Shadow" {
        return Color(red: 0.251, green: 0.196, blue: 0.275, opacity: 1.000)
    } else {
        return Color.white
    }
}
