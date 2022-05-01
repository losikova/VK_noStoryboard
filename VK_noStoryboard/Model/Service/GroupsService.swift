//
//  GroupsService.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 5/1/22.
//

import Foundation
import UIKit
import Alamofire
import RealmSwift

extension Service {
    
    func getGroups() {
        
//        let firebaneService = [FirebaseGroups]()
//        let ref = Database.database().reference(withPath: "Group")
        
        params["extended"] = 1
        let url = baseUrl + "/groups.get"
        
        AF.request(url, method: .get, parameters: params).responseData {
            response in
            guard let data = response.value else { return }
            
            do {
                let groups = try! JSONDecoder().decode(GroupResponse.self, from: data).response.items
//                groups.forEach { group in
//                    let firebaseGroups = FirebaseGroups(name: group.name, id: group.id)
//                    let groupsRef = ref.child(group.name.lowercased())
//                    groupsRef.setValue(firebaseGroups.toAnyObject())
//                }
                self.realmService.saveData(objects: groups)
            } catch {
                print(error)
            }
        }
    }
    
}
