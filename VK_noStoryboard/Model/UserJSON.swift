//
//  UserJSON.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 03.03.2022.
//

import Foundation
import RealmSwift

class UserResponse: Decodable {
    let response: UserItem
}

class UserItem: Decodable {
    let items: [User]
}

class User: Object, Decodable {
    @objc dynamic var id = 0
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var avatar = ""

    enum CodingKeys: String, CodingKey {
        case avatar = "photo_100"
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
