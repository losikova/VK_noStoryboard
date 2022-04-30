//
//  NewsViewController+setupUI.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 4/21/22.
//

import UIKit

extension NewsViewController {
    
    func setupUI() {
        view.addSubview(newsTableView)
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            newsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            newsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        newsTableView.clipsToBounds = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed(_:)))
        addButton.tintColor = .systemBlue
        navigationItem.setRightBarButton(addButton, animated: true)
    }
    
}
