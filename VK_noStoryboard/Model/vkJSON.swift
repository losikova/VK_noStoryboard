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
//        case friends = "/friends.get"
//        case photos = "/photos.get"
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
            var friends = [User]()
            
            do {
                friends = try! JSONDecoder().decode(UserResponse.self, from: data).response.items
                //                    print(friends)
                completion(friends)
            } catch {
                print(error)
            }
            
            
        }
    }
    
    //        if objects == .photos {
    //            params["album_id"] = "profile"
    //        }
    //
    //        if objects == .groupOf {
    //            params["q"] = "Music"
    //        }s
    
    
}
