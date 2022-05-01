//
//  NewsViewController.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit
import RealmSwift

class NewsViewController: UIViewController {

    let newsTableView = UITableView()
    
    let newsArray = [
        news(avtor: "Adele", date: "12:12:12", inscription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", image: UIImage(named: "Adele")!),
        news(avtor: "Lady Gaga", date: "12:12:12", inscription: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", image: UIImage(named: "Lady Gaga")!),
        news(avtor: "Lady Gaga", date: "12:12:12", inscription: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
        news(avtor: "Adele", date: "12:12:12", image: UIImage(named: "Adele")!)
    ]
    
    var array = [PostsJSON]()
    var sectionArray = [[RowName]]()
    
    enum RowName {
        case author
        case inscription
        case image
        case bottom
    }
    
    enum NewsType: String {
        case post
        case photo
        case photoTag
        case wallPhoto
        case friend
        case note
        case audio
        case video
    }
    
    var myNewsfeed: Results<News>? {
        realm.readData(object: News.self)
    }
    var token: NotificationToken?
    var newsRealm = [News]()
    let webService = Service(token: Session.instance.token)
    let realm = RealmService()
    
    override func loadView() {
        super.loadView()
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsTableView.register(AuthorTableViewCell.self, forCellReuseIdentifier: AuthorTableViewCell.identifier)
        newsTableView.register(InscriptionTableViewCell.self, forCellReuseIdentifier: InscriptionTableViewCell.identifier)
        newsTableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.identifier)
        newsTableView.register(BottomTableViewCell.self, forCellReuseIdentifier: BottomTableViewCell.identifier)
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        fillNewsArray()
    }
}
