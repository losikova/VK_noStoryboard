//
//  GalleryCollectionViewCell.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 20.02.2022.
//

import UIKit

final class GalleryCollectionViewCell: UICollectionViewCell {
    
    // MARK: Public properties
    static let identifier = "reuseIdentifierGallery"
    
    /// Основное view ячейки
    let photoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    /// View загрузки картинки
    let loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

    // MARK: Private properties
    private let likesView: BottomItemView = {
        let view = BottomItemView(item: .like)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    // MARK: Init
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

// MARK: - Private SetupUI
private extension GalleryCollectionViewCell {
    
    func setupUI() {
        addSubview(photoImageView)
        addSubview(likesView)
        addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.leftAnchor.constraint(equalTo: leftAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            photoImageView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            likesView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor),
            likesView.rightAnchor.constraint(equalTo: photoImageView.rightAnchor),
            likesView.widthAnchor.constraint(equalToConstant: 40),
            likesView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            loadingView.heightAnchor.constraint(equalToConstant: 60),
            loadingView.widthAnchor.constraint(equalToConstant: 240)
        ])
        
        loadingView.animateLoading(.start)
    }
}
