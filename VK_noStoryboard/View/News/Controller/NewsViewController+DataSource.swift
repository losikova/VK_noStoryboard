//
//  NewsViewController+DataSource.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 4/21/22.
//

import UIKit

extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionArray[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        newsRealm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = newsRealm[indexPath.section]
        let type = sectionArray[indexPath.section][indexPath.item]
//        print(news)
//        print(type)
        
        let cell = chooseCell(from: type, news: news, indexPath: indexPath)
        cell.alpha = 0
        return cell
    }
    
    
    func chooseCell(from rowType: RowName, news: News, indexPath: IndexPath) -> UITableViewCell {
        
        switch rowType {
        case .author:
            let authorCell = newsTableView.dequeueReusableCell(withIdentifier: AuthorTableViewCell.identifier, for: indexPath) as! AuthorTableViewCell
            print(news.sourceId)
//            authorCell.avtor = news.avtor
//            authorCell.date = news.date
            newsTableView.rowHeight = 60
            return authorCell
            
        case .inscription:
            let inscriptionCell = newsTableView.dequeueReusableCell(withIdentifier: InscriptionTableViewCell.identifier, for: indexPath) as! InscriptionTableViewCell
//            inscriptionCell.inscriptionLabel.text = news.inscription
            newsTableView.rowHeight = 60
            return inscriptionCell
            
        case .image:
            let imageCell = newsTableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as! ImageTableViewCell
//            imageCell.photosView.image = news.image
            newsTableView.rowHeight = 415
            return imageCell
            
        case .bottom:
            let bottomCell = newsTableView.dequeueReusableCell(withIdentifier: BottomTableViewCell.identifier, for: indexPath) as! BottomTableViewCell
            newsTableView.rowHeight = 20
            return bottomCell
        }
    }
}
