//
//  GalleryViewController+notifications.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 4/21/22.
//

import UIKit

extension GalleryViewController {
    
    func createNotificationToken() {
        token = myPhotos?.observe { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .initial(let photosData):
                print("\(photosData.count) photos")
            case .update(_ ,
                         deletions: let deletions,
                         insertions: let insertions ,
                         modifications: let modifications):
                
                let deletionsIndexPath = deletions.map { IndexPath(row: $0, section: 0) }
                let insertionsIndexPath = insertions.map { IndexPath(row: $0, section: 0) }
                let modificationsIndexPath = modifications.map { IndexPath(row: $0, section: 0) }
                
                DispatchQueue.main.async {
                    self.galleryCollectionView.performBatchUpdates {
                        self.galleryCollectionView.deleteItems(at: deletionsIndexPath)
                        self.galleryCollectionView.insertItems(at: insertionsIndexPath)
                        self.galleryCollectionView.reloadItems(at: modificationsIndexPath)
                    }
                }
            case .error(let error):
                print("\(error)")
            }
        }
    }
    
}
