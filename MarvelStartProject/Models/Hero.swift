//
//  HeroModel.swift
//  MarvelStartProject
//
//  Created by Jean Lucas Vitor on 12/05/22.
//

import Foundation

struct APIResult: Codable {
    var data: APICharacterData
}

struct APICharacterData: Codable {
    var count: Int
    var results: [Character]
}

struct Character: Codable, Identifiable {
    var id: Int
    var name: String
    var description: String?
//    var thumbnail: [String: String]
}
