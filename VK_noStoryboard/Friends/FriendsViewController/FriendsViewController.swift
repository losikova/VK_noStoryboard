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
    
    var friendsRealm = [Friend]()
    let loadingView = LoadingView()
    let webService = vkService(token: Session.instance.token)
    let realm = RealmService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        friendsTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        friendsTableView.rowHeight = 70
        friendsTableView.dataSource = self
        friendsTableView.delegate = self
        
        fillFriendsArray()
    }
    
    func continueController() {
        friendsTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        friendsTableView.rowHeight = 70
        friendsTableView.dataSource = self
        friendsTableView.delegate = self
    }
    
    private func setupUI() {
        self.title = "Friends"
        
        view.addSubview(friendsTableView)
        friendsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            friendsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            friendsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            friendsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            friendsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        friendsTableView.clipsToBounds = true
        
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingView.heightAnchor.constraint(equalToConstant: 60),
            loadingView.widthAnchor.constraint(equalToConstant: 240)
        ])
        loadingView.clipsToBounds = true
    }
}
