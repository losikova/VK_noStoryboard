//
//  NewsViewController.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit

struct news {
    var avtor: String
    var date: String
    var inscription: String
    var image: UIImage
}

final class NewsViewController: UIViewController {
    
   // MARK: Private properties
    private let mainView = NewsMainView()
    
    // MARK: Init
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.fillNewsArray()
        mainView.createNotificationToken()
    }
}
