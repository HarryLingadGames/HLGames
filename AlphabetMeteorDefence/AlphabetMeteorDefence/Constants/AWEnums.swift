//
//  AWEnums.swift
//  AlphabetWar
//
//  Created by Harry on 12/5/20.
//  Copyright © 2020 Harry. All rights reserved.
//

import Foundation

enum LetterType: String {
    case a = "enemy_letter_a"
    case b = "enemy_letter_b"
    case c = "enemy_letter_c"
    case d = "enemy_letter_d"
    case e = "enemy_letter_e"
    case f = "enemy_letter_f"
    case g = "enemy_letter_g"
    case h = "enemy_letter_h"
    case i = "enemy_letter_i"
    case j = "enemy_letter_j"
    case k = "enemy_letter_k"
    case l = "enemy_letter_l"
    case m = "enemy_letter_m"
    case n = "enemy_letter_n"
    case o = "enemy_letter_o"
    case p = "enemy_letter_p"
    case q = "enemy_letter_q"
    case r = "enemy_letter_r"
    case s = "enemy_letter_s"
    case t = "enemy_letter_t"
    case u = "enemy_letter_u"
    case v = "enemy_letter_v"
    case w = "enemy_letter_w"
    case x = "enemy_letter_x"
    case y = "enemy_letter_y"
    case z = "enemy_letter_z"
    case shift = "shift_letter"
    case abc = "abc_letter"
    case delete = "delete_letter"
    case enter = "return_letter"
    case space = "space_letter"

    static func getType(stringLetter: String) -> LetterType {
        switch stringLetter {
        case "a":
            return LetterType.a
        case "b":
            return LetterType.b
        case "c":
            return LetterType.c
        case "d":
            return LetterType.d
        case "e":
            return LetterType.e
        case "f":
            return LetterType.f
        case "g":
            return LetterType.g
        case "h":
            return LetterType.h
        case "i":
            return LetterType.i
        case "j":
            return LetterType.j
        case "k":
            return LetterType.k
        case "l":
            return LetterType.l
        case "m":
            return LetterType.m
        case "n":
            return LetterType.n
        case "o":
            return LetterType.o
        case "p":
            return LetterType.p
        case "q":
            return LetterType.q
        case "r":
            return LetterType.r
        case "s":
            return LetterType.s
        case "t":
            return LetterType.t
        case "u":
            return LetterType.a
        case "v":
            return LetterType.v
        case "w":
            return LetterType.w
        case "x":
            return LetterType.x
        case "y":
            return LetterType.y
        case "z":
            return LetterType.z
        default:
            return LetterType.a
        }
    }
}




enum GameStatus: Int{
    case StandBy = 0
    case Play = 1
    case GameOver = 2
}
