//
//  Character.swift
//  ChineseCharacters
//
//  Created by mac on 15.10.2023.
//

import Foundation

struct Character: Decodable {
    let char: String?
    let radical: String?
    let readings: Reading?
    let totalstrokes: String?
}

struct Reading: Decodable {
    let mandarinpinyin: [String]?
}

struct Course: Decodable {
    let name: String
}

struct Dinasties: Decodable {
    let dynasties: [DynastyInfo]?
}

struct DynastyInfo: Decodable {
    let title: String?
}
