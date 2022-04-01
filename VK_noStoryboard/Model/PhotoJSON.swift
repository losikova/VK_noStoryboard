//
//  PhotoJSON.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 03.03.2022.
//

import Foundation
import RealmSwift

class PhotoResponse: Decodable {
    let response: PhotoItem
}

class PhotoItem: Decodable {
    let items: [Photo]
}

class Photo: Object, Decodable {
    @objc dynamic var id = 0
    @objc dynamic var ownerId = 0
    dynamic var sizes = List<Size>()
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case sizes
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class Size: Object, Codable {
    @objc dynamic var url = ""
    @objc dynamic var type = ""
}
