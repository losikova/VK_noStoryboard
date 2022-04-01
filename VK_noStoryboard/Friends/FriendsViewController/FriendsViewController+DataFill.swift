//
//  FriendsViewController+DataFill.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit

extension FriendsViewController {
    
    func fillFriendsArray() {
        webService.getFriends { [weak self] friends in
            self?.realm.readData(object: Friend.self).forEach{ self?.friendsRealm.append($0) }
            self?.friendsRealm.sort(by: {$0.firstName < $1.firstName})
            self?.fillSectionLetters()
            self?.friendsTableView.reloadData()
        }
    }
    
    func fillSectionLetters() {
        for friend in friendsRealm {
            let letter = String(friend.firstName.prefix(1)).uppercased()
            if !sectionLetters.contains(letter) {
                sectionLetters.append(letter)
            }
        }
    }
    
    func friendsBySection(letter: String) -> [Friend] {
        var resultArray = [Friend]()
        for friend in friendsRealm {
            if friend.firstName.prefix(1).uppercased() == letter.uppercased() {
                resultArray.append(friend)
            }
        }
        return resultArray
    }
}
