//
//  FriendsService.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 5/1/22.
//

import Foundation
import UIKit
import Alamofire
import RealmSwift

extension Service {
    
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
    
}
