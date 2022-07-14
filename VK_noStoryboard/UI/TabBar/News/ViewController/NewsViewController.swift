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

final class NewsViewController: UIViewController {
    
    // MARK: Private Properties
    private let newsTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    private var array = [PostsJSON]()
    private let newsArray = [
        news(avtor: "Adele", date: "12:12:12", inscription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", image: UIImage(named: "Adele")!),
        news(avtor: "Lady Gaga", date: "12:12:12", inscription: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", image: UIImage(named: "Lady Gaga")!)]
    
    // MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        newsTableView.dataSource = self
        
        setupUI()
        //        getData()
    }
}

// MARK: - Row height protocol
extension NewsViewController: NewsTableViewCellProtocol {
    
    func setRowHeight(_ height: CGFloat) {
        newsTableView.rowHeight = height
    }
}

// MARK: - Private SetupUI
private extension NewsViewController {
    
    func setupUI() {
        view.addSubview(newsTableView)
        
        NSLayoutConstraint.activate([
            newsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            newsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            newsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed(_:)))
        addButton.tintColor = .systemBlue
        navigationItem.setRightBarButton(addButton, animated: true)
    }
    
}

// MARK: - Data Source
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        
        let news = newsArray[indexPath.item]
        cell.configure(avtor: news.avtor,
                       date: news.date,
                       inscription: news.inscription,
                       image: news.image)
        cell.delegate = self
        
        return cell
    }
    
}

// MARK: - Private Actions
private extension NewsViewController {
    
    @objc func addPressed(_ sender: UIBarButtonItem) {
        print(self.array.first?.title ?? "")
    }
    
    //    func getData() {
    //        vkJSON().reguest { codabelData in
    //            self.array = codabelData
    //            self.newsTableView.reloadData()
    //            print(codabelData, "Fetch")
    //        }
    //    }
    
    
}
