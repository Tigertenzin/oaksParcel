//
//  statCalcs.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/9/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation

func calcHP(baseHP: Double, IV: Double, EV: Double, Level: Double, GenBelow3: Bool) -> Int {
    var totalHP: Double = 0
    
    if GenBelow3 == true {
        return Int(totalHP)
    } else {
        totalHP = (2 * baseHP + IV + EV/4)*Level
        totalHP = totalHP / 100
        return Int(totalHP + Level + 10)
    }
}

//1["Hardy",
//2"Lonely (+Atk, -Def)",
//3"Brave (+Atk, -Spd)",
//4"Adamant (+Atk, -SpA)",
//5"Naughty (+Atk, -SpD)",
//6"Bold (+Def, -Atk)",
//7"Docile",
//8"Relaxed (+Def, -Spd)",
//9"Impish (+Def, -SpA)",
//10"Lax (+Def, -SpD)",
//11"Timid (+Spd, -Atk)",
//12"Hasty (+Spd, -Def)",
//13"Serious",
//14"Jolly (+Spd, -SpA)",
//15"Naive (+Spd, -SpD)",
//16"Modest 15(+SpA, -Atk)",
//17"Mild (+SpA, -Def)",
//18"Quiet (+SpA, -Spd)",
//19"Bashful",
//20"Rash (+SpA, -SpD)",
//21"Calm (+SpD, -Atk)",
//22"Gentle (+SpD, -Def)",
//23"Sassy (+SpD, -Spd)",
//24"Careful (+SpD, -SpA)",
//25"Quirky"]

func calcOther(base: Double, type: Int, IV: Double, EV: Double, Level: Double, nature: Int, GenBelow3: Bool) -> Int {
    var total: Double = 0
    
    let plusAtk = [1,2,3,4]
    let plusDef = [5,7,8,9]
    let plusSpA = [15,16,17,19]
    let plusSpD = [20,21,22,23]
    let plusSpd = [10,11,13,14]
    
    let minusAtk = [5,10,15,20]
    let minusDef = [1,11,16,21]
    let minusSpA = [3,8,13,23]
    let minusSpD = [4,9,14,19]
    let minusSpd = [2,7,17,22]
    
    var natureMod: Double = 1
    if type == 1 {
        if plusAtk.contains(nature) {
            natureMod = 1.1
        } else if minusAtk.contains(nature) {
            natureMod = 0.9
        }
    } else if type == 2 {
        if plusDef.contains(nature) {
            natureMod = 1.1
        } else if minusDef.contains(nature) {
            natureMod = 0.9
        }
    } else if type == 3 {
        if plusSpA.contains(nature) {
            natureMod = 1.1
        } else if minusSpA.contains(nature) {
            natureMod = 0.9
        }
    } else if type == 4 {
        if plusSpD.contains(nature) {
            natureMod = 1.1
        } else if minusSpD.contains(nature) {
            natureMod = 0.9
        }
    } else if type == 5 {
        if plusSpd.contains(nature) {
            natureMod = 1.1
        } else if minusSpd.contains(nature) {
            natureMod = 0.9
        }
    }
    
    if GenBelow3 == true {
        return Int(total)
    } else {
        total = (2 * base + IV + EV/4)*Level
        total = total * natureMod / 100
        return Int(total + 5)
    }
}
