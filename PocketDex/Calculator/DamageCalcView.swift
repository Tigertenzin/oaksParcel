//
//  DamageCalcView.swift
//  PocketDex
//
//  Created by Thomas Tenzin on 7/30/20.
//  Copyright © 2020 Thomas Tenzin. All rights reserved.
//

import SwiftUI

enum ModalView {
    case pkmn1
    case pkmn2
    case field
}

struct DamageCalcView: View {
    
    var pokemonList:  [Pokemon]
    var pokemonTypeList:  [PokemonType]
    var pokemonStatList:  [PokemonStat]
    var moveList:  [Move]
    var moveEffectList:  [MoveEffectProse]
    var typeList:  [Type]
    var abilityList:  [Ability]
    var abilityProseList:  [AbilityProse]
    var pokemonAbilitiesList:  [PokemonAbilities]
    var itemList:  [Item]
    var itemProseList:  [ItemProse]
    
    var genderList = ["Male", "Female", "None"]
    var statTypeList = ["HP", "Atk.", "Def.", "Sp. Atk.", "Sp. Def.", "Speed"]
    var natureList = ["Hardy", "Lonely (+Atk, -Def)", "Brave (+Atk, -Spd)", "Adamant (+Atk, -SpA)", "Naughty (+Atk, -SpD)", "Bold (+Def, -Atk)", "Docile", "Relaxed (+Def, -Spd)", "Impish (+Def, -SpA)", "Lax (+Def, -SpD)", "Timid (+Spd, -Atk)", "Hasty (+Spd, -Def)", "Serious", "Jolly (+Spd, -SpA)", "Naive (+Spd, -SpD)", "Modest (+SpA, -Atk)", "Mild (+SpA, -Def)", "Quiet (+SpA, -Spd)", "Bashful", "Rash (+SpA, -SpD)", "Calm (+SpD, -Atk)", "Gentle (+SpD, -Def)", "Sassy (+SpD, -Spd)", "Careful (+SpD, -SpA)", "Quirky"]
    var statusList = ["Healthy", "Poisoned", "Badly Poisoned", "Burned", "Paralyzed", "Asleep", "Frozen"]
    
    @State var modalView: ModalView = .pkmn1
    
    @State private var searchText = ""
    @State private var isSheetShown = false
    
    // Details on your pokemon for the calc
    @State private var PKMN1 = Pokemon()
    @State private var level1: Double = 100
    @State private var gender1 = 1
    @State private var ability1 = Ability()
    @State private var nature1 = 0
    @State private var status1 = 0
    @State private var EVs1: [Double] = [0,0,0,0,0,0]
    @State private var IVs1: [Double] = [31,31,31,31,31,31]
    @State private var Mods1: [Double] = [0,0,0,0,0,0]
    @State private var Move1_1 = Move()
    @State private var Move2_1 = Move()
    @State private var Move3_1 = Move()
    @State private var Move4_1 = Move()
    var types1: [PokemonType] {
        return getTypes(typeList: self.pokemonTypeList, pkmnID: self.PKMN1.id)
    }
    var pokemonAbilities1: [PokemonAbilities] {
        return getAbilities(pokemonAbilitiesList: pokemonAbilitiesList, pkmnID: self.PKMN1.id)
    } 
    var abilities1: [Ability] {
        return findAbilites(pokemonAbilities: pokemonAbilities1, abilityList: abilityList)
    }
    var hp1: Int {
        return calcHP(baseHP: Double(self.pokemonStatList[PKMN1.id*6 - 6].base_stat), IV: self.IVs1[0], EV: self.EVs1[0], Level: self.level1, GenBelow3: false)
    }
    var atk1: Int {
        return calcOther(base: Double(self.pokemonStatList[PKMN1.id*6 - 5].base_stat), type: 1, IV: self.IVs1[1], EV: self.EVs1[1], Level: self.level1, nature: nature1, GenBelow3: false)
    }
    var def1: Int {
        return calcOther(base: Double(self.pokemonStatList[PKMN1.id*6 - 4].base_stat), type: 2, IV: self.IVs1[2], EV: self.EVs1[2], Level: self.level1, nature: nature1, GenBelow3: false)
    }
    var spA1: Int {
        return calcOther(base: Double(self.pokemonStatList[PKMN1.id*6 - 3].base_stat), type: 3, IV: self.IVs1[3], EV: self.EVs1[3], Level: self.level1, nature: nature1, GenBelow3: false)
    }
    var spD1: Int {
        return calcOther(base: Double(self.pokemonStatList[PKMN1.id*6 - 2].base_stat), type: 4, IV: self.IVs1[4], EV: self.EVs1[4], Level: self.level1, nature: nature1, GenBelow3: false)
    }
    
    // Details on the foe pokemon for the calc
    @State private var PKMN2 = Pokemon()
    @State private var level2: Double = 100
    @State private var gender2 = 1
    @State private var ability2 = Ability()
    @State private var nature2 = 0
    @State private var status2 = 0
    @State private var EVs2: [Double] = [0,0,0,0,0,0]
    @State private var IVs2: [Double] = [31,31,31,31,31,31]
    @State private var Mods2: [Double] = [0,0,0,0,0,0]
    @State private var Move1_2 = Move()
    @State private var Move2_2 = Move()
    @State private var Move3_2 = Move()
    @State private var Move4_2 = Move()
    var types2: [PokemonType] {
        return getTypes(typeList: self.pokemonTypeList, pkmnID: self.PKMN2.id)
    }
    var pokemonAbilities2: [PokemonAbilities] {
        return getAbilities(pokemonAbilitiesList: pokemonAbilitiesList, pkmnID: self.PKMN2.id)
    }
    var abilities2: [Ability] {
        return findAbilites(pokemonAbilities: pokemonAbilities2, abilityList: abilityList)
    }
    var hp2: Int {
        return calcHP(baseHP: Double(self.pokemonStatList[PKMN2.id*6 - 6].base_stat), IV: self.IVs2[0], EV: self.EVs2[0], Level: self.level2, GenBelow3: false)
    }
    var atk2: Int {
        return calcOther(base: Double(self.pokemonStatList[PKMN2.id*6 - 5].base_stat), type: 1, IV: self.IVs2[1], EV: self.EVs2[1], Level: self.level2, nature: nature2, GenBelow3: false)
    }
    var def2: Int {
        return calcOther(base: Double(self.pokemonStatList[PKMN2.id*6 - 4].base_stat), type: 2, IV: self.IVs2[2], EV: self.EVs2[2], Level: self.level2, nature: nature2, GenBelow3: false)
    }
    var spA2: Int {
        return calcOther(base: Double(self.pokemonStatList[PKMN2.id*6 - 3].base_stat), type: 3, IV: self.IVs2[3], EV: self.EVs2[3], Level: self.level2, nature: nature2, GenBelow3: false)
    }
    var spD2: Int {
        return calcOther(base: Double(self.pokemonStatList[PKMN2.id*6 - 2].base_stat), type: 4, IV: self.IVs2[4], EV: self.EVs2[4], Level: self.level2, nature: nature2, GenBelow3: false)
    }
    
    // Details about the field
    @State private var battleStyleSelection = 0
    let battleStyleList: [String] = ["Singles", "Doubles"]
    
    @State private var terrainSelection = 0
    let terrainList: [String] = ["None", "Electric", "Grassy", "Misty", "Psychic"]
    
    @State private var weatherSelection = 0
    let weatherList: [String] = ["None", "Sun", "Rain", "Sandstorm", "Hail", "Harsh Sunshine", "Heavy Rain", "Strong Winds"]
    
    @State private var gravity = false
    @State private var screens1 = [false, false]
    @State private var helpingHand1 = false
    @State private var auroraVeil1 = false
    @State private var screens2 = [false, false]
    @State private var helpingHand2 = false
    @State private var auroraVeil2 = false
    
    // Move damages
    var move1_1_damage: Double {
        return damageCalc(typeList: typeList, move1: Move1_1, types1: types1, ability1: ability1, level1: level1, totalStats1: [hp1, atk1, def1, spA1, spD1], status1: status1, types2: types2, ability2: ability2, totalStats2: [hp2, atk2, def2, spA2, spD2], screens2: screens2, auroraVeil2: auroraVeil2, battleStyle: battleStyleSelection, weather: weatherSelection)
    }
    var move2_1_damage: Double {
        return damageCalc(typeList: typeList, move1: Move2_1, types1: types1, ability1: ability1, level1: level1, totalStats1: [hp1, atk1, def1, spA1, spD1], status1: status1, types2: types2, ability2: ability2, totalStats2: [hp2, atk2, def2, spA2, spD2], screens2: screens2, auroraVeil2: auroraVeil2, battleStyle: battleStyleSelection, weather: weatherSelection)
    }
    var move3_1_damage: Double {
        return damageCalc(typeList: typeList, move1: Move3_1, types1: types1, ability1: ability1, level1: level1, totalStats1: [hp1, atk1, def1, spA1, spD1], status1: status1, types2: types2, ability2: ability2, totalStats2: [hp2, atk2, def2, spA2, spD2], screens2: screens2, auroraVeil2: auroraVeil2, battleStyle: battleStyleSelection, weather: weatherSelection)
    }
    var move4_1_damage: Double {
        return damageCalc(typeList: typeList, move1: Move4_1, types1: types1, ability1: ability1, level1: level1, totalStats1: [hp1, atk1, def1, spA1, spD1], status1: status1, types2: types2, ability2: ability2, totalStats2: [hp2, atk2, def2, spA2, spD2], screens2: screens2, auroraVeil2: auroraVeil2, battleStyle: battleStyleSelection, weather: weatherSelection)
    }
    var move1_2_damage: Double {
        return damageCalc(typeList: typeList, move1: Move1_2, types1: types2, ability1: ability2, level1: level2, totalStats1: [hp2, atk2, def2, spA2, spD2], status1: status2, types2: types1, ability2: ability1, totalStats2: [hp1, atk1, def1, spA1, spD1], screens2: screens1, auroraVeil2: auroraVeil1, battleStyle: battleStyleSelection, weather: weatherSelection)
    }
    var move2_2_damage: Double {
        return damageCalc(typeList: typeList, move1: Move2_2, types1: types2, ability1: ability2, level1: level2, totalStats1: [hp2, atk2, def2, spA2, spD2], status1: status2, types2: types1, ability2: ability1, totalStats2: [hp1, atk1, def1, spA1, spD1], screens2: screens1, auroraVeil2: auroraVeil1, battleStyle: battleStyleSelection, weather: weatherSelection)
    }
    var move3_2_damage: Double {
        return damageCalc(typeList: typeList, move1: Move3_2, types1: types2, ability1: ability2, level1: level2, totalStats1: [hp2, atk2, def2, spA2, spD2], status1: status2, types2: types1, ability2: ability1, totalStats2: [hp1, atk1, def1, spA1, spD1], screens2: screens1, auroraVeil2: auroraVeil1, battleStyle: battleStyleSelection, weather: weatherSelection)
    }
    var move4_2_damage: Double {
        return damageCalc(typeList: typeList, move1: Move4_2, types1: types2, ability1: ability2, level1: level2, totalStats1: [hp2, atk2, def2, spA2, spD2], status1: status2, types2: types1, ability2: ability1, totalStats2: [hp1, atk1, def1, spA1, spD1], screens2: screens1, auroraVeil2: auroraVeil1, battleStyle: battleStyleSelection, weather: weatherSelection)
    }
    
    
    @EnvironmentObject var selectedTheme: UserTheme
    
    var columns: [GridItem] = [
        GridItem(.flexible(minimum: 64), spacing: 8),
        GridItem(.flexible(minimum: 32), spacing: 8),
        GridItem(.flexible(minimum: 32), spacing: 8),
        GridItem(.flexible(minimum: 32), spacing: 8),
        GridItem(.flexible(minimum: 32), spacing: 8),
        GridItem(.flexible(minimum: 32), spacing: 8)
    ]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                DamageCalcResultView(PKMN1: $PKMN1,
                                     Move1_1: $Move1_1,
                                     Move2_1: $Move2_1,
                                     Move3_1: $Move3_1,
                                     Move4_1: $Move4_1,
                                     move1_1_damage: move1_1_damage,
                                     move2_1_damage: move2_1_damage,
                                     move3_1_damage: move3_1_damage,
                                     move4_1_damage: move4_1_damage,
                                     PKMN2: $PKMN2,
                                     Move1_2: $Move1_2,
                                     Move2_2: $Move2_2,
                                     Move3_2: $Move3_2,
                                     Move4_2: $Move4_2,
                                     move1_2_damage: move1_2_damage,
                                     move2_2_damage: move2_2_damage,
                                     move3_2_damage: move3_2_damage,
                                     move4_2_damage: move4_2_damage)
                    .padding()
                    .frame(width: geo.size.width)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    .animation(.default)
                
                DamageCalcDetailView(pokemonList: self.pokemonList,
                                     pokemonTypeList: self.pokemonTypeList,
                                     pokemonStatList: self.pokemonStatList,
                                     typeList: self.typeList,
                                     moveList: self.moveList,
                                     yourMon: true,
                                     PKMN1: $PKMN1,
                                     level1: $level1,
                                     gender1: $gender1,
                                     ability1: $ability1,
                                     nature1: $nature1,
                                     status1: $status1,
                                     EVs1: $EVs1,
                                     IVs1: $IVs1,
                                     Mods1: $Mods1,
                                     Move1_1: $Move1_1,
                                     Move2_1: $Move2_1,
                                     Move3_1: $Move3_1,
                                     Move4_1: $Move4_1,
                                     modalView: $modalView,
                                     isSheetShown: $isSheetShown,
                                     types1: types1)
                    .padding()
                    .frame(width: geo.size.width)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)

                DamageCalcDetailView(pokemonList: self.pokemonList,
                                     pokemonTypeList: self.pokemonTypeList,
                                     pokemonStatList: self.pokemonStatList,
                                     typeList: self.typeList,
                                     moveList: self.moveList,
                                     yourMon: false,
                                     PKMN1: $PKMN2,
                                     level1: $level2,
                                     gender1: $gender2,
                                     ability1: $ability2,
                                     nature1: $nature2,
                                     status1: $status2,
                                     EVs1: $EVs2,
                                     IVs1: $IVs2,
                                     Mods1: $Mods2,
                                     Move1_1: $Move1_2,
                                     Move2_1: $Move2_2,
                                     Move3_1: $Move3_2,
                                     Move4_1: $Move4_2,
                                     modalView: $modalView,
                                     isSheetShown: $isSheetShown,
                                     types1: types2)
                    .padding()
                    .frame(width: geo.size.width)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                
                DamageCalcFeildDetailView(battleStyleSelection: $battleStyleSelection,
                                          terrainSelection: $terrainSelection,
                                          weatherSelection: $weatherSelection,
                                          gravity: $gravity,
                                          screens1: $screens1,
                                          helpingHand1: $helpingHand1,
                                          auroraVeil1: $auroraVeil1,
                                          screens2: $screens2,
                                          helpingHand2: $helpingHand2,
                                          auroraVeil2: $auroraVeil2,
                                          modalView: $modalView,
                                          isSheetShown: $isSheetShown)
                .padding()
                .frame(width: geo.size.width)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
            }
            .navigationBarTitle("Damage Calculator")
        }
        .padding(.horizontal)
        
        .sheet(isPresented: $isSheetShown, onDismiss: {
                    self.isSheetShown = false
                }, content: {
                    if self.modalView == .pkmn1 {
                        DamageCalcPKNNAddView(pokemonList: self.pokemonList,
                                              moveList: self.moveList,
                                              abilityForPKMN: self.abilities1,
                                              PKMN1: $PKMN1,
                                              level1: $level1,
                                              gender1: $gender1,
                                              ability1: $ability1,
                                              nature1: $nature1,
                                              status1: $status1,
                                              EVs1: $EVs1,
                                              IVs1: $IVs1,
                                              Mods1: $Mods1,
                                              Move1_1: $Move1_1,
                                              Move2_1: $Move2_1,
                                              Move3_1: $Move3_1,
                                              Move4_1: $Move4_1)
                            .accentColor(selectedTheme.themeColor)
                    } else if self.modalView == .pkmn2 {
                        DamageCalcPKNNAddView(pokemonList: self.pokemonList,
                                              moveList: self.moveList,
                                              abilityForPKMN: self.abilities2,
                                              PKMN1: $PKMN2,
                                              level1: $level2,
                                              gender1: $gender2,
                                              ability1: $ability2,
                                              nature1: $nature2,
                                              status1: $status2,
                                              EVs1: $EVs2,
                                              IVs1: $IVs2,
                                              Mods1: $Mods2,
                                              Move1_1: $Move1_2,
                                              Move2_1: $Move2_2,
                                              Move3_1: $Move3_2,
                                              Move4_1: $Move4_2)
                            .accentColor(selectedTheme.themeColor)
                    } else if self.modalView == .field {
                        DamageCalcFieldView(battleStyleSelection: $battleStyleSelection,
                                            terrainSelection: $terrainSelection,
                                            weatherSelection: $weatherSelection,
                                            gravity: $gravity,
                                            screens1: $screens1,
                                            helpingHand1: $helpingHand1,
                                            auroraVeil1: $auroraVeil1,
                                            screens2: $screens2,
                                            helpingHand2: $helpingHand2,
                                            auroraVeil2: $auroraVeil2)
                            .accentColor(selectedTheme.themeColor)
                    }
                })
    }
}

func damageCalc(typeList: [Type], move1: Move, types1: [PokemonType], ability1: Ability, level1: Double, totalStats1: [Int], status1: Int, types2: [PokemonType], ability2: Ability, totalStats2: [Int], screens2: [Bool], auroraVeil2: Bool, battleStyle: Int, weather: Int) -> Double {
    var damage: Double = 0
    var mod: Double = 0
    var mod_Target: Double = 0
    var mod_Weather: Double = 0
    var mod_STAB: Double = 1
    var mod_Type: Double = 1
    var mod_Burn: Double = 1
    var mod_Other: Double = 1
    
    // Target Modifier
    if battleStyle==6 || battleStyle==9 || battleStyle==11 || battleStyle==14 { // double battle
        if move1.target_id==1 {
            mod_Target = 0.75
        } else {
            mod_Target = 1
        }
    } else {
        mod_Target = 1
    }
    
    // Weather modifier
    if weather==1 { // if its sunny
        if move1.type_id==10 {
            mod_Weather = 1.5
        } else if move1.type_id==11 {
            mod_Weather = 0.5
        } else {
            mod_Weather = 1
        }
    } else if weather==2 { // if its rainy
        if move1.type_id==10 {
            mod_Weather = 0.5
        } else if move1.type_id==11 {
            mod_Weather = 1.5
        } else {
            mod_Weather = 1
        }
    } else if weather==5 { // if harsh sun
        if move1.type_id==10 {
            mod_Weather = 1.5
        } else if move1.type_id==11 {
            mod_Weather = 0
        } else {
            mod_Weather = 1
        }
    } else if weather==6 { // if heavy rain
        if move1.type_id==10 {
            mod_Weather = 0
        } else if move1.type_id==11 {
            mod_Weather = 1.5
        } else {
            mod_Weather = 1
        }
    } else {
        mod_Weather = 1
    }
    
    // STAB modifier
    for type in types1 {
        if type.type_id == move1.type_id {
            if ability1.id == 91 { // if ability is "Adaptability"
                mod_STAB = 2
            } else {
                mod_STAB = 1.5
            }
        }
    }
    
    // Type-effectiveness modifier.
    for type2 in types2 {
        mod_Type = mod_Type*typeEffec(type1: typeList[move1.type_id-1], type2: type2)
    }
    
    // Burn modifier
    if status1==3 {
        if ability1.id == 62 {
            if move1.damage_class_id==2{
                mod_Burn = 1.5
            } else {
                mod_Burn = 1
            }
        } else if ability1.id == 138 {
            if move1.damage_class_id==3{
                mod_Burn = 1.5
            } else {
                mod_Burn = 0.5
            }
        } else {
            if move1.damage_class_id==2 {
                mod_Burn = 0.5
            } else {
                mod_Burn = 1
            }
        }
    } else {
        mod_Burn=1
    }
    
    //Other modifiers (move or ability specific)
    if screens2[0] && move1.damage_class_id==2 {
        mod_Other = mod_Other * 0.5 // Reflect
    }
    if screens2[1] && move1.damage_class_id==3 {
        mod_Other = mod_Other * 0.5 // Light Screen
    }
    if auroraVeil2 {
        if move1.damage_class_id==2 {
            if ability1.id != 151  && screens2[0]==false {
                mod_Other = mod_Other * 0.5
            }
        } else if move1.damage_class_id==3 {
            if ability1.id != 151  && screens2[1]==false {
                mod_Other = mod_Other * 0.5
            }
        }
    }
    if ability2.id==218 { //Ability Fluffy
        if move1.damage_class_id==2 && move1.type_id != 10 {
            mod_Other = mod_Other * 0.5
        } else if move1.damage_class_id==3 && move1.type_id==10 {
            mod_Other = mod_Other * 2
        }
    } else if ability2.id==111 || ability2.id==232 || ability2.id==116{ // Ability Filter or Prism-Armor or Solid-Rock
        if mod_Type > 1 {
            mod_Other = mod_Other * 0.75
        }
    }
    
    if ability1.id==233 { // Ability NueroForce
        if mod_Type > 1 {
            mod_Other = mod_Other * 1.25
        }
    } else if ability1.id==110 {
        if mod_Type < 1 {
            mod_Other = mod_Other * 2
        }
    }
    
    
    
    // Final modifier
    mod = mod_Target*mod_Weather*mod_STAB*mod_Type*mod_Burn*mod_Other
    
    // code to caluclate damage
    damage = (level1*0.4 + 2) * Double(move1.power != nil ? move1.power! : 0) * Double(move1.damage_class_id==2 ? totalStats1[1] : totalStats1[3]) / Double(move1.damage_class_id==2 ? totalStats2[2] : totalStats2[4]) / 50 + 2
    
    return damage*mod
}

