//
//  GalleryViewController.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 20.02.2022.
//

import UIKit
import RealmSwift

class GalleryViewController: UIViewController {
    
    var myPhotos: Results<Photo>? {
        realm.readData(object: Photo.self)
    }
    var token: NotificationToken?
    let webService = Service(token: Session.instance.token)
    var photosURL = [String]()
    let realm = RealmService()
    var userId = 0

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
    
    override func loadView() {
        super.loadView()
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        galleryCollectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier)
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        
        print("Tapped User ID: \(userId)")
        
        fillPhotosArray()
        createNotificationToken()
    }
    
    private func fillPhotosArray() {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            self.webService.getPhotos(of: self.userId)
        }
        
        realm.readData(object: Photo.self).forEach {
            if $0.ownerId == userId {
                $0.sizes.forEach { size in
                    if size.type == "r" {
                        photosURL.append(size.url)
                    }
                }
            }
        }
        galleryCollectionView.reloadData()
    }
    
    func getImage(url: String) -> UIImage {
        let url = URL(string: url)!
        let imageData = try? Data(contentsOf: url)
        
        return UIImage(data: imageData!)!
    }
}
