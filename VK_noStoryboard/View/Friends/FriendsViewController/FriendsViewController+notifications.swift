//
//  FriendsViewController+notifications.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 4/21/22.
//

import UIKit

extension FriendsViewController {
    
    func createNotificationToken() {
        token = myFriends?.observe { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .initial(let friendsData):
                print("\(friendsData.count) friends")
            case .update(_ ,
                         deletions: let deletions,
                         insertions: let insertions ,
                         modifications: let modifications):

                let deletionsIndexPath = deletions.map { IndexPath(row: $0, section: 0) }
                let insertionsIndexPath = insertions.map { IndexPath(row: $0, section: 0) }
                let modificationsIndexPath = modifications.map { IndexPath(row: $0, section: 0) }

                DispatchQueue.main.async {
                    self.friendsTableView.beginUpdates()

                    self.friendsTableView.deleteRows(at: deletionsIndexPath, with: .automatic)

                    self.friendsTableView.insertRows(at: insertionsIndexPath, with: .automatic)

                    self.friendsTableView.reloadRows(at: modificationsIndexPath, with: .automatic)

                    self.friendsTableView.endUpdates()
                }
            case .error(let error):
                print("\(error)")
            }
        }
    }
    
}
