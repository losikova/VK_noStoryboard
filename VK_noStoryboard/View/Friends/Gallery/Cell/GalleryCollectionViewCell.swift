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
    let loadingView = LoadingView()
    
    static let identifier = "reuseIdentifierGallery"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

