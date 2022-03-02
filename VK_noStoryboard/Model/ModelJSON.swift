//
//  ModelJSON.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 28.02.2022.
//

import Foundation

// MARK: - User
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

// MARK: - Photo
class PhotoResponse: Decodable {
    let response: PhotoItem
}

class PhotoItem: Decodable {
    let items: [Photo]
}

class Photo: Decodable {
    var owner_id = 0
    var url = ""
    var sizes: [Size]
    
//    var likes =
    
    enum CodingKeys: String, CodingKey {
        case owner_id
        case url
        case sizes
    }
    
    required init(from decoder: Decoder) throws {
        let item = try decoder.container(keyedBy: CodingKeys.self)
        
        self.owner_id = try item.decode(Int.self, forKey: .owner_id)
        self.sizes = try item.decode([Size].self, forKey: .sizes)
    }
    
    struct Size: Codable {
        var url = ""
        var type = ""
    }
}

// MARK: - Group
class Group: Decodable {
    var id = 0
    var avatar = ""
    var name = ""
    var description = ""
    
    enum CodingKeys: String, CodingKey {
        case avatar = "photo_200"
    }
}
