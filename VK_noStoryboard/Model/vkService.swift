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
    
    func getFriends(completion: @escaping ([User]) -> Void) {
        params["fields"] = "nickname,photo_100"
        let url = baseUrl + "/friends.get"

        AF.request(url, method: .get, parameters: params).responseData {[weak self] response in
            guard let data = response.value else { return }
            
            do {
                let friends = try! JSONDecoder().decode(UserResponse.self, from: data).response.items
                DispatchQueue.main.async {
                    self?.realmService.saveData(objects: friends)
                }
                completion(friends)
            } catch {
                print(error)
            }
        }
    }
    
    func getPhotos(of userID: Int, completion: @escaping ([Photo]) -> Void) {
        params["album_id"] = "profile"
        params["owner_id"] = userID
        params["extended"] = 1
        
        let url = baseUrl + "/photos.get"
        
        AF.request(url, method: .get, parameters: params).responseData {[weak self]
            response in
            guard let data = response.value else { return }

            do {
                let photos = try! JSONDecoder().decode(PhotoResponse.self, from: data).response.items
                DispatchQueue.main.async {
                    self?.realmService.saveData(objects: photos)
                }
                completion(photos)
            } catch {
                print(error)
            }
        }
    }
    
    func getGroups(completion: @escaping ([Group]) -> Void) {
        params["extended"] = 1
        let url = baseUrl + "/groups.get"

        AF.request(url, method: .get, parameters: params).responseData {[weak self]
            response in
            guard let data = response.value else { return }

            do {
                let groups = try! JSONDecoder().decode(GroupResponse.self, from: data).response.items
                DispatchQueue.main.async {
                    self?.realmService.saveData(objects: groups)
                }
                completion(groups)
            } catch {
                print(error)
            }
        }
    }
}
