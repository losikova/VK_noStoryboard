//
//  TabBarViewController.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private let friendsController = UINavigationController.init(rootViewController: FriendsViewController())
    private let groupsController: UINavigationController = UINavigationController.init(rootViewController: GroupsViewController())

    private let newsController = UINavigationController.init(rootViewController: NewsViewController())

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        viewControllers = [friendsController, groupsController, newsController]
        
        let friendsItem = UITabBarItem(title: "Friends", image: UIImage(systemName: "person.2"), tag: 0)
        let groupsItem = UITabBarItem(title: "My Groups", image: UIImage(systemName: "person.3"), tag: 1)
        let newsItem = UITabBarItem(title: "News", image: UIImage(systemName: "newspaper"), tag: 2)
        friendsController.tabBarItem = friendsItem
        groupsController.tabBarItem = groupsItem
        newsController.tabBarItem = newsItem
        
    }
}
