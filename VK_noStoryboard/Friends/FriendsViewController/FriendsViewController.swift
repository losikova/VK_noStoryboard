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
        createNotificationToken()
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

extension FriendsViewController {
    func createNotificationToken() {
        token = myFriends?.observe { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .initial(let friendsData):
                print("\(friendsData.count) friends")
            case .update(_ ,
                         deletions: let deletions,
                         insertions: let insertions ,
                         modifications: let modifications):

                let deletionsIndexPath = deletions.map { IndexPath(row: $0, section: 0) }
                let insertionsIndexPath = insertions.map { IndexPath(row: $0, section: 0) }
                let modificationsIndexPath = modifications.map { IndexPath(row: $0, section: 0) }

                DispatchQueue.main.async {
                    self.friendsTableView.beginUpdates()

                    self.friendsTableView.deleteRows(at: deletionsIndexPath, with: .automatic)

                    self.friendsTableView.insertRows(at: insertionsIndexPath, with: .automatic)

                    self.friendsTableView.reloadRows(at: modificationsIndexPath, with: .automatic)

                    self.friendsTableView.endUpdates()
                }
            case .error(let error):
                print("\(error)")
            }
        }

    }
}
