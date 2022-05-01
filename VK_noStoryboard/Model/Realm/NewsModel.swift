//
//  NewsModel.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 5/1/22.
//

import Foundation
import RealmSwift

class NewsResponse: Decodable {
    let response: NewsItem
}

class NewsItem: Decodable {
    let items: [News]
}

class News: Object, Decodable {
    @objc dynamic var postId = 0
    @objc dynamic var sourceId = 0
    @objc dynamic var date = 0
    @objc dynamic var text: String? = ""
    dynamic var attachments = List<Attachment>()

    enum CodingKeys: String, CodingKey {
        case postId = "post_id"
        case sourceId = "source_id"
        case date
        case text
        case attachments
    }
    
    override static func primaryKey() -> String? {
        return "postId"
    }
    
    override init() {
        super.init()
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.attachments = try container.decodeIfPresent(List<Attachment>.self, forKey: .attachments) ?? List<Attachment>()
    }
}

class Attachment: Object, Decodable {
    @objc dynamic var type = ""
    @objc dynamic var photo: Photo? = Photo()
}
