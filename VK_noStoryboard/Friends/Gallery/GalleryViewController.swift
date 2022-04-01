//
//  GalleryViewController.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 20.02.2022.
//

import UIKit
import RealmSwift

class GalleryViewController: UIViewController {
    
    let webService = vkService(token: Session.instance.token)
    var photosURL = [String]()
    let realm = RealmService()
    var userId = 0
    let loadingView = LoadingView()

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
        
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingView.heightAnchor.constraint(equalToConstant: 60),
            loadingView.widthAnchor.constraint(equalToConstant: 240)
        ])
        loadingView.clipsToBounds = true
        loadingView.animateLoading(.start)
        
        view.layoutIfNeeded()
    }
    
    private func fillPhotosArray() {
        webService.getPhotos(of: userId) { [weak self] photos in
            self?.realm.readData(object: Photo.self).forEach {
                if $0.ownerId == self?.userId {
                    
                    $0.sizes.forEach { size in
                        if size.type == "r" {
                            self?.photosURL.append(size.url)
                        }
                    }
                    
                }
            }
            self?.galleryCollectionView.reloadData()
        }
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
        
        loadingView.animateLoading(.start)
        DispatchQueue.main.async {[weak self] in
            cell.photoImageView.image = self?.getImage(url: (self?.photosURL[indexPath.item])!)
            
            self?.loadingView.animateLoading(.stop)
        }
        return cell
    }
}

