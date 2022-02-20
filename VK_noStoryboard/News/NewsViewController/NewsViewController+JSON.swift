//
//  NewsViewController+JSON.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 20.02.2022.
//

import Foundation

extension NewsViewController {
    
    func getData() {
        vkJSON().reguest { codabelData in
            self.array = codabelData
            self.newsTableView.reloadData()
            print(codabelData, "Fetch")
        }
    }
    
    
}
