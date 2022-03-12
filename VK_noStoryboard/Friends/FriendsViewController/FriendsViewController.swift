//
//  FriendsViewController.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit

class FriendsViewController: UIViewController {
    
    let friendsTableView = UITableView()
    var friendsArray = [Friend]()
    var sectionLetters = [String]()
    
    let loadingView = LoadingView()
    let webService = vkJSON(token: Session.instance.token)
    
//    let friendsNames = [
//        "Adele": [UIImage(named: "Adele")!, UIImage(named: "Adele")!, UIImage(named: "Adele")!],
//        "Cate Blanchett": [UIImage(named: "Cate Blanchett")!],
//        "Damiano David": [UIImage(named: "Damiano David")!],
//        "Emily Blunt": [UIImage(named: "Emily Blunt")!],
//        "Helena Bonham Carter": [UIImage(named: "Helena Bonham Carter")!],
//        "Johnny Depp": [UIImage(named: "Johnny Depp")!],
//        "Keanu Reeves": [UIImage(named: "Keanu Reeves")!],
//        "Lady Gaga": [UIImage(named: "Lady Gaga")!],
//        "Lana Parilla": [UIImage(named: "Lana Parilla")!],
//        "Meryl Streep": [UIImage(named: "Meryl Streep")!],
//        "Rihanna": [UIImage(named: "Rihanna")!],
//        "Robert Downey Jr": [UIImage(named: "Robert Downey Jr")!],
//        "Ryan Reynolds": [UIImage(named: "Ryan Reynolds")!],
//        "Sara Ramirez": [UIImage(named: "Sara Ramirez")!],
//        "Sarah Paulson": [UIImage(named: "Sarah Paulson")!],
//        "Timothee Chalamet": [UIImage(named: "Timothee Chalamet")!]
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
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
    
    private func setup() {
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
        loadingView.isHidden = false
        loadingView.animateLoading()
    }
    
}
