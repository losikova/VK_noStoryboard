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
    var inscription: String?
    var image: UIImage?
}

//protocol NewsTableViewCellProtocol: AnyObject {
//    func setRowHeight(height: CGFloat)
//}

class NewsViewController: UIViewController {

    let newsTableView = UITableView()
    
    let newsArray = [
        news(avtor: "Adele", date: "12:12:12", inscription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", image: UIImage(named: "Adele")!),
        news(avtor: "Lady Gaga", date: "12:12:12", inscription: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", image: UIImage(named: "Lady Gaga")!),
        news(avtor: "Lady Gaga", date: "12:12:12", inscription: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
        news(avtor: "Adele", date: "12:12:12", image: UIImage(named: "Adele")!)
    ]
    
    var array = [PostsJSON]()
    var sectionArray = [[RowName]]()
//    var newsArrayByCells = [newsArray]()
    
    enum RowName {
        case author
        case inscription
        case image
        case bottom
    }
    
    override func loadView() {
        super.loadView()
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsTableView.register(AuthorTableViewCell.self, forCellReuseIdentifier: AuthorTableViewCell.identifier)
        newsTableView.register(InscriptionTableViewCell.self, forCellReuseIdentifier: InscriptionTableViewCell.identifier)
        newsTableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.identifier)
        newsTableView.register(BottomTableViewCell.self, forCellReuseIdentifier: BottomTableViewCell.identifier)
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
    
        rowsTypeBySection()
    }
    
    func rowsTypeBySection() {
        for news in 0...newsArray.count - 1 {
            sectionArray.append([])
            sectionArray[news].append(.author)
            
            if newsArray[news].inscription != nil &&
                newsArray[news].image != nil
            {
                sectionArray[news].append(.inscription)
                sectionArray[news].append(.image)
                sectionArray[news].append(.bottom)
            } else if newsArray[news].image == nil {
                sectionArray[news].append(.inscription)
                sectionArray[news].append(.bottom)
            } else if newsArray[news].inscription == nil {
                sectionArray[news].append(.image)
                sectionArray[news].append(.bottom)
            }
        }
    }
    
    func rowType(index: Int) -> RowName {
        var itemNumber = 0
        var rowName = RowName.author
        for section in sectionArray {
            let sectionStep = section.count - 1
            if index <= (itemNumber + sectionStep) {
                let num = index - itemNumber
                rowName = section[num]
                break
            }
            itemNumber += sectionStep
        }
        return rowName
    }
    
    func newsNumber(by index: Int) -> Int {
        var num = 0
        for section in sectionArray {
            for i in 0...section.count {
                if i == index { return num }
            }
            num += 1
        }
        return num
    }
    
    @objc func addPressed(_ sender: UIBarButtonItem) {
        print(self.array.first?.title ?? "")
    }
}

//extension NewsViewController: NewsTableViewCellProtocol {
//    func setRowHeight(height: CGFloat) {
//        newsTableView.rowHeight = height
//    }
//
//}


