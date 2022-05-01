//
//  NewsViewController+notifications.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 5/1/22.
//

import UIKit

extension NewsViewController {
    
    func createNotificationToken() {
        token = myNewsfeed?.observe { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .initial(let newsData):
                print("\(newsData.count) news")
            case .update(_ ,
                         deletions: let deletions,
                         insertions: let insertions ,
                         modifications: let modifications):

                let deletionsIndexPath = deletions.map { IndexPath(row: $0, section: 0) }
                let insertionsIndexPath = insertions.map { IndexPath(row: $0, section: 0) }
                let modificationsIndexPath = modifications.map { IndexPath(row: $0, section: 0) }

                DispatchQueue.main.async {
                    self.newsTableView.beginUpdates()

                    self.newsTableView.deleteRows(at: deletionsIndexPath, with: .automatic)

                    self.newsTableView.insertRows(at: insertionsIndexPath, with: .automatic)

                    self.newsTableView.reloadRows(at: modificationsIndexPath, with: .automatic)

                    self.newsTableView.endUpdates()
                }
            case .error(let error):
                print("\(error)")
            }
        }
    }
}
