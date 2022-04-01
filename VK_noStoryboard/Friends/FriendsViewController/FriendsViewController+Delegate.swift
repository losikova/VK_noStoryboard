//
//  FriendsViewController+Delegate.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit

extension FriendsViewController: UITableViewDelegate, CustomTableViewCellProtocol {
    
    func performAfterTap(row: IndexPath) {
        tableView(friendsTableView, didSelectRowAt: row)
    }
}
