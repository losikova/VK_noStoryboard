//
//  GalleryViewController+DateSource.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 4/21/22.
//

import UIKit

extension GalleryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosURL.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = galleryCollectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier, for: indexPath) as! GalleryCollectionViewCell
        
        cell.loadingView.animateLoading(.start)
        DispatchQueue.main.async {[weak self] in
            cell.photoImageView.image = self?.getImage(url: (self?.photosURL[indexPath.item])!)
            
            cell.loadingView.animateLoading(.stop)
        }
        return cell
    }
    
}
