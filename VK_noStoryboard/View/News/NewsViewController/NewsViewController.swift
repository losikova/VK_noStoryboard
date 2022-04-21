//
//  NewsViewController.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit

struct news {
    var avtor: String
    var date: String
    var inscription: String
    var image: UIImage
}

class NewsViewController: UIViewController {

    let newsTableView = UITableView()
    
    let newsArray = [
        news(avtor: "Adele", date: "12:12:12", inscription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", image: UIImage(named: "Adele")!),
        news(avtor: "Lady Gaga", date: "12:12:12", inscription: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", image: UIImage(named: "Lady Gaga")!)]
    
    var array = [PostsJSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        setupUI()
//        getData()
    }
    
    @objc func addPressed(_ sender: UIBarButtonItem) {
        print(self.array.first?.title ?? "")
    }
}

extension NewsViewController: NewsTableViewCellProtocol {
    func setRowHeight(height: CGFloat) {
        newsTableView.rowHeight = height
    }
    
}


