//
//  GalleryViewController.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 20.02.2022.
//

import UIKit

class GalleryViewController: UIViewController {

    let galleryCollectionView : UICollectionView = {
        let size = (UIScreen.main.bounds.width - 9) / 2
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 3, bottom: 5, right: 3)
        layout.itemSize = CGSize(width: size, height: size+20)
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var photos = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        galleryCollectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier)
      
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(galleryCollectionView)
//        galleryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            galleryCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            galleryCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            galleryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            galleryCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        galleryCollectionView.clipsToBounds = true
        
        view.layoutIfNeeded()
    }

}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = galleryCollectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier, for: indexPath) as! GalleryCollectionViewCell
        cell.photoImageView.image = photos[indexPath.item]
        return cell
    }
    
}

