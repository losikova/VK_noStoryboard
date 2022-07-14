//
//  FirebaseGroups.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 4/2/22.
//

import Firebase

final class FirebaseGroups {
    
    let name: String
    let id: Int
    let ref: DatabaseReference?
    
    // MARK: Init
    init(name: String, id: Int) {
        self.ref = nil
        self.id = id
        self.name = name
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let id = value["id"] as? Int,
            let name = value["name"] as? String
        else {
            return nil
        }
        self.ref = snapshot.ref
        self.name = name
        self.id = id
    }
    
    func toAnyObject() -> [String: Any] {
        ["id": id,
         "name": name]
    }
}
