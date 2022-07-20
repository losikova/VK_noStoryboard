//
//  NewsDescriptionCell.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 7/19/22.
//

import UIKit

final class NewsDescriptionCell: UITableViewCell {
    
    // MARK: Public properties
    static let identifier = "reusableIdentifierNewsDescriptionCell"
    
    // MARK: Private properties
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 4
        label.lineBreakMode = .byWordWrapping
        label.clipsToBounds = true
        return label
    }()
    
    // MARK: Init
    func configure(description: String) {
        self.descriptionLabel.text = description
        setupView()
    }
}

// MARK: - Private
private extension NewsDescriptionCell {
    
    func setupView() {
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor),
            descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
