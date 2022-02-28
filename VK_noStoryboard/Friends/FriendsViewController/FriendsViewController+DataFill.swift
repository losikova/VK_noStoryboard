//
//  FriendsViewController+DataFill.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit

extension FriendsViewController {
    
    func fillFriendsArray() {
//        webService.getFriends { friends in
//            print(friends.count)
//            for friend in friends {
//                print(Session.instance.token)
//                let url = URL(string: friend.avatar)!
//                DispatchQueue.main.async {
//                    let imageData = try? Data(contentsOf: url)
//
//                    let name = "\(friend.first_name) \(friend.last_name)"
//                    let avatar = UIImage(data: imageData!)
//                    let photos = self.getPhotos(of: friend.id)
//
//                    let newFriend = Friend(name: name, avatar: avatar!, photos: photos)
//                    self.friendsArray.append(newFriend)
//                    self.friendsTableView.reloadData()
//                }
//            }
//        }
        for (name, photos) in friendsNames {
//            let url = URL(string: "https://sun9-8.userapi.com/s/v1/ig2/5e9szCucfQBV_afmQNk2PLr5h2OBX_gH2avEE-wljn7tq_GdPVmsgvf2tlQVSIJ7c_00c32kIKgJ2X37_CJkSMiM.jpg?size=200x200&quality=96&crop=340,0,1920,1920&ava=1")!
//            let data = try? Data(contentsOf: url)
            let friend = Friend(name: name, avatar: UIImage(named: name)!, photos: photos)
            friendsArray.append(friend)
        }
        friendsArray.sort(by: {$0.name < $1.name})
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
