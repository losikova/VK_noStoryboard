//
//  NewsMainView.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 7/19/22.
//

import UIKit

final class NewsMainView: UIView {
    
    // MARK: Private Properties
    private enum Section: CaseIterable {
        case author
        case description
        case photos
        case footer
    }
    private let newsTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.separatorStyle = .none
        view.allowsSelection = false
        return view
    }()
    private var array = [PostsJSON]()
    private let newsArray = [
        news(avtor: "Adele", date: "12:12:12", inscription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", image: UIImage(named: "Adele")!)]
    
    // MARK: Init
    init() {
        super.init(frame: .zero)
        newsTableView.register(NewsAuthorCell.self, forCellReuseIdentifier: NewsAuthorCell.identifier)
        newsTableView.register(NewsDescriptionCell.self, forCellReuseIdentifier: NewsDescriptionCell.identifier)
        newsTableView.register(NewsPhotosCell.self, forCellReuseIdentifier: NewsPhotosCell.identifier)
        newsTableView.register(NewsFooterCell.self, forCellReuseIdentifier: NewsFooterCell.identifier)
        
        newsTableView.dataSource = self
        newsTableView.delegate = self
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private
private extension NewsMainView {
    
    func setupView() {
        addSubview(newsTableView)
        
        NSLayoutConstraint.activate([
            newsTableView.leftAnchor.constraint(equalTo: leftAnchor),
            newsTableView.topAnchor.constraint(equalTo: topAnchor),
            newsTableView.rightAnchor.constraint(equalTo: rightAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed(_:)))
//        addButton.tintColor = .systemBlue
//        navigationItem.setRightBarButton(addButton, animated: true)
    }
}

// MARK: - Data Source
extension NewsMainView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Section.allCases.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = getSection(of: indexPath.row)
        
        switch section {
        case .author:
            guard let cell = newsTableView.dequeueReusableCell(
                withIdentifier: NewsAuthorCell.identifier,
                for: indexPath) as? NewsAuthorCell else { fatalError("Could not create author cell") }
            cell.configure(name: newsArray[0].avtor,
                           date: newsArray[0].date)
            return cell
        case .description:
            guard let cell = newsTableView.dequeueReusableCell(
                withIdentifier: NewsDescriptionCell.identifier,
                for: indexPath) as? NewsDescriptionCell else { fatalError("Could not create description cell") }
            cell.configure(description: newsArray[0].inscription)
            return cell
        case .photos:
            guard let cell = newsTableView.dequeueReusableCell(
                withIdentifier: NewsPhotosCell.identifier,
                for: indexPath) as? NewsPhotosCell else { fatalError("Could not create photos cell") }
            cell.configure(image: newsArray[0].image)
            return cell
        case .footer:
            guard let cell = newsTableView.dequeueReusableCell(
                withIdentifier: NewsFooterCell.identifier,
                for: indexPath) as? NewsFooterCell else { fatalError("Could not create footer cell") }
            cell.configure()
            return cell
        }
    }
    
    
    private func getSection(of index: Int) -> Section {
        let numberOfSection: CGFloat = CGFloat(index) + 1
        if numberOfSection / 4 == CGFloat(Int(numberOfSection / 4)) {
            return .footer
        } else if numberOfSection / 3 == CGFloat(Int(numberOfSection / 3)) {
            return .photos
        } else  if numberOfSection / 2 == CGFloat(Int(numberOfSection / 2)) {
            return .description
        } else {
            return .author
        }
    }
    
}

// MARK: Delegate
extension NewsMainView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = getSection(of: indexPath.row)
        
        switch section {
        case .author:
            return 60
        case .description:
            return 100
        case .photos:
            return 250
        case .footer:
            return 40
        }
    }
}

// MARK: - Private Actions
private extension NewsMainView {
    
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
