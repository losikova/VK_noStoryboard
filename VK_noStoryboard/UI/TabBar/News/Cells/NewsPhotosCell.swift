//
//  NewsPhotosCell.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 7/19/22.
//

import UIKit

final class NewsPhotosCell: UITableViewCell {
    
    // MARK: Public properties
    static let identifier = "reusableIdentifierNewsPhotosCell"
    
    // MARK: Private properties
    private var photosView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    // MARK: Init
    func configure(image: UIImage) {
        self.photosView.image = image
        setupView()
    }
}

// MARK: - Private
private extension NewsPhotosCell {
    
    func setupView() {
        addSubview(photosView)
        
        NSLayoutConstraint.activate([
            photosView.bottomAnchor.constraint(equalTo: bottomAnchor),
            photosView.topAnchor.constraint(equalTo: topAnchor),
            photosView.leftAnchor.constraint(equalTo: leftAnchor),
            photosView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
