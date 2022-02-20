//
//  GalleryCollectionViewCell.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 20.02.2022.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {

    let photoImageView = UIImageView()
    let likesView = BottomItemView(item: .like)
    
    static let identifier = "reuseIdentifierGallery"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {        
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
        
    }

}

