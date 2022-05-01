//
//  NewsService.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 5/1/22.
//

import Foundation
import UIKit
import Alamofire
import RealmSwift

extension Service {
    
    func getNews() {
        params["filter"] = "post"
        let url = baseUrl + "/newsfeed.get"
        
        AF.request(url, method: .get, parameters: params).responseData {
            response in
            guard let data = response.value else { return }
            
            do {
                let news = try! JSONDecoder().decode(NewsResponse.self, from: data).response.items
                print(news[0].sourceId)
                self.realmService.saveData(objects: news)
            } catch {
                print(error)
            }
        }
    }
    
}
