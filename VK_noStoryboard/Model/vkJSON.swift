//
//  vkJSON.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import Foundation
import UIKit
import Alamofire

class vkJSON {
    
    init(token: String) {
        params["access_token"] = token
    }
    
//    enum Objects: String {
//        case groups = "/groups.get"
//        case groupOf = "/groups.search"
//    }
    
    private let baseUrl = "https://api.vk.com/method"
    
    private var params: Parameters = [
        "access_token": "",
        "v": "5.131"
    ]
    
    func getFriends(completion: @escaping ([User]) -> Void) {
        params["fields"] = "nickname,photo_100"
        let url = baseUrl + "/friends.get"

        Alamofire.request(url, method: .get, parameters: params).responseData { response in
            guard let data = response.value else { return }
            
            do {
                let friends = try! JSONDecoder().decode(UserResponse.self, from: data).response.items
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

        Alamofire.request(url, method: .get, parameters: params).responseData { response in
            guard let data = response.value else { return }

            do {
                let photos = try! JSONDecoder().decode(PhotoResponse.self, from: data).response.items
                completion(photos)
            } catch {
                print(error)
            }
        }
    }
    
    func getGroups(completion: @escaping ([Group]) -> Void) {
        params["extended"] = 1
        let url = baseUrl + "/groups.get"

        Alamofire.request(url, method: .get, parameters: params).responseData { response in
            guard let data = response.value else { return }

            do {
                let groups = try! JSONDecoder().decode(GroupResponse.self, from: data).response.items
                completion(groups)
            } catch {
                print(error)
            }
        }
    }

    //        if objects == .groupOf {
    //            params["q"] = "Music"
    //        }
    
    
}
