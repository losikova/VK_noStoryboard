//
//  PhotoService.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 5/1/22.
//

import Foundation
import UIKit
import Alamofire
import RealmSwift

extension Service {
    
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
    
}
