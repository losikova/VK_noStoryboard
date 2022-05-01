//
//  FriendsViewController.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit
import RealmSwift

class FriendsViewController: UIViewController {
    
    let friendsTableView = UITableView()
    var sectionLetters = [String]()
    
    var myFriends: Results<Friend>? {
        realm.readData(object: Friend.self)
    }
    var token: NotificationToken?
    var friendsRealm = [Friend]()
    let loadingView = LoadingView()
    let webService = Service(token: Session.instance.token)
    let realm = RealmService()
    
    override func loadView() {
        super.loadView()
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.animateLoading(.start)
        
        friendsTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        friendsTableView.dataSource = self
        friendsTableView.delegate = self
        
        self.title = "Friends"
        fillFriendsArray()
        createNotificationToken()
    }

}
