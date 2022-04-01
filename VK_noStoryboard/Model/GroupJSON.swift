//
//  GroupJSON.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 03.03.2022.
//

import Foundation
import RealmSwift

class GroupResponse: Decodable {
    let response: GroupItem
}

class GroupItem: Decodable {
    let items: [Group]
}

class Group: Object, Decodable {
    @objc dynamic var id = 0
    @objc dynamic var avatar = ""
    @objc dynamic var name = ""
    
    enum CodingKeys: String, CodingKey {
        case avatar = "photo_100"
        case id
        case name
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
