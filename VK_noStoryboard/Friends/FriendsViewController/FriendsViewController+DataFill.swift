//
//  FriendsViewController+DataFill.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit

extension FriendsViewController {
    
    func fillFriendsArray() {
        webService.getFriends()
        realm.readData(object: Friend.self).forEach{ friendsRealm.append($0) }
        friendsRealm.sort(by: {$0.firstName < $1.firstName})
        fillSectionLetters()
        friendsTableView.reloadData()
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
