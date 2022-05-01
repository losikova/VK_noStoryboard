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
//import FirebaseDatabase

class Service {
    
    let realmService = RealmService()
    let baseUrl = "https://api.vk.com/method"
    
    var params: Parameters = [
        "access_token": "",
        "v": "5.131"
    ]
    
    init(token: String) {
        params["access_token"] = token
    }
}
