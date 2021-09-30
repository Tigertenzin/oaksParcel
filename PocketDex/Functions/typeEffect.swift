//
//  typeEffect.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 8/14/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import Foundation

func typeEffec(type1: Type, type2: PokemonType) -> Double {
    // Type1 is the attacking move type
    // Type2 is the receiving type
    
    let id1_super = [Int]()
    let id1_notsup = [6, 9]
    let id1_no = [8]
    
    let id2_super = [1, 6, 9, 15, 17]
    let id2_notsup = [3, 4, 7, 14, 18]
    let id2_no = [8]
    
    let id3_super = [2, 7, 12]
    let id3_notsup = [6, 9, 13]
    let id3_no = [Int]()
    
    let id4_super = [12, 18]
    let id4_notsup = [4, 5, 6, 8]
    let id4_no = [9]
    
    let id5_super = [4, 6, 9, 10 ,13]
    let id5_notsup = [7, 12]
    let id5_no = [3]
    
    let id6_super = [3, 7, 10, 15]
    let id6_notsup = [2, 5, 9]
    let id6_no = [Int]()
    
    let id7_super = [12, 14, 17]
    let id7_notsup = [2, 3, 4, 8, 9, 10, 18]
    let id7_no = [Int]()
    
    let id8_super = [8, 14]
    let id8_notsup = [17]
    let id8_no = [1]
    
    let id9_super = [6, 15, 18]
    let id9_notsup = [9, 10, 11, 13]
    let id9_no = [Int]()
    
    let id10_super = [7, 9, 13, 15]
    let id10_notsup = [6, 10, 11, 16]
    let id10_no = [Int]()
    
    let id11_super = [5, 6, 10]
    let id11_notsup = [11, 12, 16]
    let id11_no = [Int]()
    
    let id12_super = [5, 6, 11]
    let id12_notsup = [3, 4, 7, 9, 10, 12, 16]
    let id12_no = [Int]()
    
    let id13_super = [3, 11]
    let id13_notsup = [12, 13, 16]
    let id13_no = [5]
    
    let id14_super = [2, 4]
    let id14_notsup = [9, 14]
    let id14_no = [17]
    
    let id15_super = [3, 5, 12, 16]
    let id15_notsup = [9, 10, 11, 15]
    let id15_no = [Int]()
    
    let id16_super = [16]
    let id16_notsup = [9]
    let id16_no = [18]
    
    let id17_super = [8, 14]
    let id17_notsup = [2, 17, 18]
    let id17_no = [Int]()
    
    let id18_super = [2, 16, 17]
    let id18_notsup = [4, 9, 10]
    let id18_no = [Int]()
    
    if type1.id == 1 {
        if id1_super.contains(type2.type_id) {
            return 2
        } else if id1_notsup.contains(type2.type_id) {
            return 0.5
        } else if id1_no.contains(type2.type_id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 2 {
        if id2_super.contains(type2.type_id) {
            return 2
        } else if id2_notsup.contains(type2.type_id) {
            return 0.5
        } else if id2_no.contains(type2.type_id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 3 {
        if id3_super.contains(type2.type_id) {
            return 2
        } else if id3_notsup.contains(type2.type_id) {
            return 0.5
        } else if id3_no.contains(type2.type_id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 4 {
        if id4_super.contains(type2.type_id) {
            return 2
        } else if id4_notsup.contains(type2.type_id) {
            return 0.5
        } else if id4_no.contains(type2.type_id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 5 {
        if id5_super.contains(type2.type_id) {
            return 2
        } else if id5_notsup.contains(type2.type_id) {
            return 0.5
        } else if id5_no.contains(type2.type_id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 6 {
        if id6_super.contains(type2.type_id) {
            return 2
        } else if id6_notsup.contains(type2.type_id) {
            return 0.5
        } else if id6_no.contains(type2.type_id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 7 {
        if id7_super.contains(type2.type_id) {
            return 2
        } else if id7_notsup.contains(type2.type_id) {
            return 0.5
        } else if id7_no.contains(type2.type_id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 8 {
        if id8_super.contains(type2.type_id) {
            return 2
        } else if id8_notsup.contains(type2.type_id) {
            return 0.5
        } else if id8_no.contains(type2.type_id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 9 {
        if id9_super.contains(type2.type_id) {
            return 2
        } else if id9_notsup.contains(type2.type_id) {
            return 0.5
        } else if id9_no.contains(type2.type_id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 10 {
        if id10_super.contains(type2.type_id) {
            return 2
        } else if id10_notsup.contains(type2.type_id) {
            return 0.5
        } else if id10_no.contains(type2.type_id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 11 {
        if id11_super.contains(type2.type_id) {
            return 2
        } else if id11_notsup.contains(type2.type_id) {
            return 0.5
        } else if id11_no.contains(type2.type_id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 12 {
        if id12_super.contains(type2.type_id) {
            return 2
        } else if id12_notsup.contains(type2.type_id) {
            return 0.5
        } else if id12_no.contains(type2.type_id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 13 {
        if id13_super.contains(type2.type_id) {
            return 2
        } else if id13_notsup.contains(type2.type_id) {
            return 0.5
        } else if id13_no.contains(type2.type_id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 14 {
        if id14_super.contains(type2.type_id) {
            return 2
        } else if id14_notsup.contains(type2.type_id) {
            return 0.5
        } else if id14_no.contains(type2.type_id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 15 {
        if id15_super.contains(type2.type_id) {
            return 2
        } else if id15_notsup.contains(type2.type_id) {
            return 0.5
        } else if id15_no.contains(type2.type_id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 16 {
        if id16_super.contains(type2.type_id) {
            return 2
        } else if id16_notsup.contains(type2.type_id) {
            return 0.5
        } else if id16_no.contains(type2.type_id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 17 {
        if id17_super.contains(type2.type_id) {
            return 2
        } else if id17_notsup.contains(type2.type_id) {
            return 0.5
        } else if id17_no.contains(type2.type_id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 18 {
        if id18_super.contains(type2.type_id) {
            return 2
        } else if id18_notsup.contains(type2.type_id) {
            return 0.5
        } else if id18_no.contains(type2.type_id) {
            return 0
        } else {
            return 1
        }
    } else {
        return 1
    }
}

func typeEffec2(type1: Type, type2: Type) -> Double {
    // Type1 is the attacking move type
    // Type2 is the receiving type
    
    let id1_super = [Int]()
    let id1_notsup = [6, 9]
    let id1_no = [8]
    
    let id2_super = [1, 6, 9, 15, 17]
    let id2_notsup = [3, 4, 7, 14, 18]
    let id2_no = [8]
    
    let id3_super = [2, 7, 12]
    let id3_notsup = [6, 9, 13]
    let id3_no = [Int]()
    
    let id4_super = [12, 18]
    let id4_notsup = [4, 5, 6, 8]
    let id4_no = [9]
    
    let id5_super = [4, 6, 9, 10 ,13]
    let id5_notsup = [7, 12]
    let id5_no = [3]
    
    let id6_super = [3, 7, 10, 15]
    let id6_notsup = [2, 5, 9]
    let id6_no = [Int]()
    
    let id7_super = [12, 14, 17]
    let id7_notsup = [2, 3, 4, 8, 9, 10, 18]
    let id7_no = [Int]()
    
    let id8_super = [8, 14]
    let id8_notsup = [17]
    let id8_no = [1]
    
    let id9_super = [6, 15, 18]
    let id9_notsup = [9, 10, 11, 13]
    let id9_no = [Int]()
    
    let id10_super = [7, 9, 12, 13, 15]
    let id10_notsup = [6, 10, 11, 16]
    let id10_no = [Int]()
    
    let id11_super = [5, 6, 10]
    let id11_notsup = [11, 12, 16]
    let id11_no = [Int]()
    
    let id12_super = [5, 6, 11]
    let id12_notsup = [3, 4, 7, 9, 10, 12, 16]
    let id12_no = [Int]()
    
    let id13_super = [3, 11]
    let id13_notsup = [12, 13, 16]
    let id13_no = [5]
    
    let id14_super = [2, 4]
    let id14_notsup = [9, 14]
    let id14_no = [17]
    
    let id15_super = [3, 5, 12, 16]
    let id15_notsup = [9, 10, 11, 15]
    let id15_no = [Int]()
    
    let id16_super = [16]
    let id16_notsup = [9]
    let id16_no = [18]
    
    let id17_super = [8, 14]
    let id17_notsup = [2, 17, 18]
    let id17_no = [Int]()
    
    let id18_super = [2, 16, 17]
    let id18_notsup = [4, 9, 10]
    let id18_no = [Int]()
    
    if type1.id == 1 {
        if id1_super.contains(type2.id) {
            return 2
        } else if id1_notsup.contains(type2.id) {
            return 0.5
        } else if id1_no.contains(type2.id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 2 {
        if id2_super.contains(type2.id) {
            return 2
        } else if id2_notsup.contains(type2.id) {
            return 0.5
        } else if id2_no.contains(type2.id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 3 {
        if id3_super.contains(type2.id) {
            return 2
        } else if id3_notsup.contains(type2.id) {
            return 0.5
        } else if id3_no.contains(type2.id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 4 {
        if id4_super.contains(type2.id) {
            return 2
        } else if id4_notsup.contains(type2.id) {
            return 0.5
        } else if id4_no.contains(type2.id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 5 {
        if id5_super.contains(type2.id) {
            return 2
        } else if id5_notsup.contains(type2.id) {
            return 0.5
        } else if id5_no.contains(type2.id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 6 {
        if id6_super.contains(type2.id) {
            return 2
        } else if id6_notsup.contains(type2.id) {
            return 0.5
        } else if id6_no.contains(type2.id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 7 {
        if id7_super.contains(type2.id) {
            return 2
        } else if id7_notsup.contains(type2.id) {
            return 0.5
        } else if id7_no.contains(type2.id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 8 {
        if id8_super.contains(type2.id) {
            return 2
        } else if id8_notsup.contains(type2.id) {
            return 0.5
        } else if id8_no.contains(type2.id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 9 {
        if id9_super.contains(type2.id) {
            return 2
        } else if id9_notsup.contains(type2.id) {
            return 0.5
        } else if id9_no.contains(type2.id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 10 {
        if id10_super.contains(type2.id) {
            return 2
        } else if id10_notsup.contains(type2.id) {
            return 0.5
        } else if id10_no.contains(type2.id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 11 {
        if id11_super.contains(type2.id) {
            return 2
        } else if id11_notsup.contains(type2.id) {
            return 0.5
        } else if id11_no.contains(type2.id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 12 {
        if id12_super.contains(type2.id) {
            return 2
        } else if id12_notsup.contains(type2.id) {
            return 0.5
        } else if id12_no.contains(type2.id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 13 {
        if id13_super.contains(type2.id) {
            return 2
        } else if id13_notsup.contains(type2.id) {
            return 0.5
        } else if id13_no.contains(type2.id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 14 {
        if id14_super.contains(type2.id) {
            return 2
        } else if id14_notsup.contains(type2.id) {
            return 0.5
        } else if id14_no.contains(type2.id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 15 {
        if id15_super.contains(type2.id) {
            return 2
        } else if id15_notsup.contains(type2.id) {
            return 0.5
        } else if id15_no.contains(type2.id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 16 {
        if id16_super.contains(type2.id) {
            return 2
        } else if id16_notsup.contains(type2.id) {
            return 0.5
        } else if id16_no.contains(type2.id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 17 {
        if id17_super.contains(type2.id) {
            return 2
        } else if id17_notsup.contains(type2.id) {
            return 0.5
        } else if id17_no.contains(type2.id) {
            return 0
        } else {
            return 1
        }
    } else if type1.id == 18 {
        if id18_super.contains(type2.id) {
            return 2
        } else if id18_notsup.contains(type2.id) {
            return 0.5
        } else if id18_no.contains(type2.id) {
            return 0
        } else {
            return 1
        }
    } else {
        return 1
    }
}

