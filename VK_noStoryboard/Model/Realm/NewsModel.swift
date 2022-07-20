//
//  NewsModel.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 7/19/22.
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
    @objc dynamic var source_id = 0
    @objc dynamic var date = 0
    @objc dynamic var text = ""

    enum CodingKeys: String, CodingKey {
        case source_id
        case date
        case text
    }

//    @objc dynamic var date = ""
//    @objc dynamic var text = ""
//
//    enum CodingKeys: String, CodingKey {
//        case date
//        case text
////        case comments
////        case likes
////        case reposts
////        case photos
//    }
//
    override class func primaryKey() -> String? {
        return "source_id"
    }
}

