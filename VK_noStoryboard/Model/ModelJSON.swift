//
//  ModelJSON.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 28.02.2022.
//

import Foundation

class UserResponse: Decodable {
    let response: UserItem
}

class UserItem: Decodable {
    let items: [User]
}

class User: Decodable {
    var id = 0
    var first_name = ""
    var last_name = ""
    var avatar = ""

    enum CodingKeys: String, CodingKey {
        case avatar = "photo_100"
        case id
        case first_name
        case last_name
    }
}

class Photo: Decodable {
    var owner_id = 0
    var url = ""
}

class Group: Decodable {
    var id = 0
    var avatar = ""
    var name = ""
    var description = ""
    
    enum CodingKeys: String, CodingKey {
        case avatar = "photo_200"
    }
}
