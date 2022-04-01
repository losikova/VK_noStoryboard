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
    let webService = vkService(token: Session.instance.token)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        galleryCollectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier)
      
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        
        print("Tapped User ID: \(userId)")
        setupUI()
        
        fillPhotosArray()
        createNotificationToken()
    }
    
    private func setupUI() {
        view.addSubview(galleryCollectionView)
        galleryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            galleryCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            galleryCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            galleryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            galleryCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        galleryCollectionView.clipsToBounds = true
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
    
    private func getImage(url: String) -> UIImage {
        let url = URL(string: url)!
        let imageData = try? Data(contentsOf: url)
        
        return UIImage(data: imageData!)!
    }
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
