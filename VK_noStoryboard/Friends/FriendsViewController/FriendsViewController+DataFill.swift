//
//  FriendsViewController+DataFill.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit

extension FriendsViewController {
    
    func fillFriendsArray() {
        for (name, photos) in friendsNames {
            let friend = User(name: name, avatar: UIImage(named: name)!, photos: photos)
            friendsArray.append(friend)
        }
        friendsArray.sort(by: {$0.name < $1.name})
    }
    
    func fillSectionLetters() {
        for friend in friendsArray {
            let letter = String(friend.name.prefix(1)).uppercased()
            if !sectionLetters.contains(letter) {
                sectionLetters.append(letter)
            }
        }
    }
    
    func friendsBySection(letter: String) -> [User] {
        var resultArray = [User]()
        for friend in friendsArray {
            if friend.name.prefix(1).uppercased() == letter.uppercased() {
                resultArray.append(friend)
            }
        }
        return resultArray
    }
}
