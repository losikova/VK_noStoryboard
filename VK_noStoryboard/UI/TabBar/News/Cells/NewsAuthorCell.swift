//
//  NewsAuthorCell.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 7/19/22.
//

import UIKit

final class NewsAuthorCell: UITableViewCell {
    
    // MARK: Public properties
    static let identifier = "reusableIdentifierNewsAuthorCell"
    
    // MARK: Private Properties
    private var photo: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    // MARK: Public Properties
    var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        return label
    }()
    var date: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        return label
    }()
    
    // MARK: Init
    func configure(name: String, date: String) {
        self.name.text = name
        self.date.text = date
        setupView()
    }
}

// MARK: - Private
private extension NewsAuthorCell {
    
    func setupView() {
        addSubview(photo)
        addSubview(name)
        addSubview(date)
        
        NSLayoutConstraint.activate([
            photo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            photo.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            photo.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            photo.widthAnchor.constraint(equalTo: photo.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            name.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            name.leftAnchor.constraint(equalTo: photo.rightAnchor, constant: 16),
            name.bottomAnchor.constraint(equalTo: date.topAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            date.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            date.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            date.leftAnchor.constraint(equalTo: photo.rightAnchor, constant: 16)
        ])
        
        photo.image = UIImage(named: name.text!)
        layoutIfNeeded()
        photo.layer.cornerRadius = (bounds.height - 16) / 2
    }
}
