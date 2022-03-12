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
    @objc dynamic var ownerId = 0
    @objc dynamic var url = ""
    @objc dynamic var sizes: [Size]
    
//    var likes =
    
    enum CodingKeys: String, CodingKey {
        case owner_id = "owner_id"
        case url
        case sizes
    }
    
    required init(from decoder: Decoder) throws {
        let item = try decoder.container(keyedBy: CodingKeys.self)
        
        self.ownerId = try item.decode(Int.self, forKey: .owner_id)
        self.sizes = try item.decode([Size].self, forKey: .sizes)
    }
    
    class Size: Object, Codable {
        @objc dynamic var url = ""
        @objc dynamic var type = ""
    }
}
