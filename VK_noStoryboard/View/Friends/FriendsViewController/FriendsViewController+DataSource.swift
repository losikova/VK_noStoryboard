//
//  FriendsViewController+DataSource.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit

extension FriendsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionLetters.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsBySection(letter: sectionLetters[section]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = friendsTableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.avatarImageView.layer.cornerRadius = 25
        
        DispatchQueue.main.async {[weak self] in
            cell.configure(friend: (self?.friendsBySection(letter: (self?.sectionLetters[indexPath.section])!)[indexPath.row])!)
            cell.rowNumber = indexPath
            
            cell.delegate = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = friendsBySection(letter: sectionLetters[indexPath.section])
        let friend = section[indexPath.row]
        let galleryController = GalleryViewController()
        
        galleryController.userId = friend.id
        
        navigationController?.pushViewController(galleryController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionLetters[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionLetters
    }
    
}

