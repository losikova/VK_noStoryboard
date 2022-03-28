//
//  realmService.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 3/25/22.
//

import Foundation
import RealmSwift

final class RealmService {
    private var realm: Realm
    
    init() {
        do {
            self.realm = try Realm()
            print(realm.configuration.fileURL)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func saveData<T: Object>(objects: [T]) {
        do {
            realm.beginWrite()
            realm.add(objects, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func readData<T: Object>(object: T.Type) -> Results<T> {
        return realm.objects(T.self)
    }
    
    func readData<T: Object>(object: T.Type,
                             key: String,
                             complition: @escaping(T) -> Void) {
        if let result = realm.object(ofType: T.self, forPrimaryKey: key) {
            complition(result)
        }
        
    }
}
