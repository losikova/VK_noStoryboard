//
//  GalleryCollectionViewCell+setupUI.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 4/21/22.
//

import UIKit

extension GalleryCollectionViewCell {
    
    func setupUI() {
        contentView.addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            photoImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(likesView)
        likesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likesView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor),
            likesView.rightAnchor.constraint(equalTo: photoImageView.rightAnchor),
            likesView.widthAnchor.constraint(equalToConstant: 40),
            likesView.heightAnchor.constraint(equalToConstant: 20)
        ])
        likesView.clipsToBounds = true
        
        contentView.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            loadingView.heightAnchor.constraint(equalToConstant: 60),
            loadingView.widthAnchor.constraint(equalToConstant: 240)
        ])
        loadingView.clipsToBounds = true
        loadingView.animateLoading(.start)
        
        contentView.layoutIfNeeded()
    }
    
}
