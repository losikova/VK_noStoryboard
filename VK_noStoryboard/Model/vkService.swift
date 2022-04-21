//
//  vkJSON.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import Foundation
import UIKit
import Alamofire
import RealmSwift
import FirebaseDatabase

class vkService {
    
    private let realmService = RealmService()
    private let baseUrl = "https://api.vk.com/method"
    
    private var params: Parameters = [
        "access_token": "",
        "v": "5.131"
    ]
    
    
    init(token: String) {
        params["access_token"] = token
    }
    
    func getFriends() {
        params["fields"] = "nickname,photo_100"
        let url = baseUrl + "/friends.get"
        
        AF.request(url, method: .get, parameters: params).responseData {
            response in
            guard let data = response.value else { return }
            
            do {
                let friends = try! JSONDecoder().decode(FriendResponse.self, from: data).response.items
                self.realmService.saveData(objects: friends)
            } catch {
                print(error)
            }
        }
    }
    
    func getPhotos(of userID: Int) {
        params["album_id"] = "profile"
        params["owner_id"] = userID
        params["extended"] = 1
        
        let url = baseUrl + "/photos.get"
        
        AF.request(url, method: .get, parameters: params).responseData {
            response in
            guard let data = response.value else { return }
            
            do {
                let photos = try! JSONDecoder().decode(PhotoResponse.self, from: data).response.items
                self.realmService.saveData(objects: photos)
            } catch {
                print(error)
            }
        }
    }
    
    func getGroups() {
        
        let firebaneService = [FirebaseGroups]()
        let ref = Database.database().reference(withPath: "Group")
        
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
