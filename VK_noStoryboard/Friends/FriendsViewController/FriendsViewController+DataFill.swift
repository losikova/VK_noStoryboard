//
//  FriendsViewController+DataFill.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit

extension FriendsViewController {
    
    func fillFriendsArray() {
        webService.getFriends { friends in
            for friend in friends {
                let url = URL(string: friend.avatar)!
                let imageData = try? Data(contentsOf: url)
                
                let name = "\(friend.first_name) \(friend.last_name)"
                let avatar = UIImage(data: imageData!)
                let photos = self.getPhotos(of: friend.id)
                
                let newFriend = Friend(name: name, avatar: avatar!, photos: photos)
                self.friendsArray.append(newFriend)
            }
            self.friendsArray.sort(by: {$0.name < $1.name})
            self.fillSectionLetters()
            self.loadingView.isHidden = true
            self.friendsTableView.reloadData()
        }
    }
    
    func getPhotos(of id: Int) -> [UIImage] {
        return [UIImage]()
    }
    
    func fillSectionLetters() {
        for friend in friendsArray {
            let letter = String(friend.name.prefix(1)).uppercased()
            if !sectionLetters.contains(letter) {
                sectionLetters.append(letter)
            }
        }
    }
    
    func friendsBySection(letter: String) -> [Friend] {
        var resultArray = [Friend]()
        for friend in friendsArray {
            if friend.name.prefix(1).uppercased() == letter.uppercased() {
                resultArray.append(friend)
            }
        }
        return resultArray
    }
}
