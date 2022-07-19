//
//  NewsFooterCell.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 7/19/22.
//

import UIKit

final class NewsFooterCell: UITableViewCell {
    
    // MARK: Public properties
    static let identifier = "reusableIdentifierNewsFooterCell"
    
    // MARK: Private properties
    private var bottomView = UIView()
    private let likesView = BottomItemView(item: .like)
    private let commentView = BottomItemView(item: .comment)
    private let shareView = BottomItemView(item: .share)
    private let viewsView = BottomItemView(item: .views(width: UIScreen.main.bounds.width))
    
    // MARK: Init
    func configure() {
        setupView()
    }
}

// MARK: - Private
private extension NewsFooterCell {
    
    func setupView() {

        addSubview(bottomView)
        bottomView.addSubview(likesView)
        bottomView.addSubview(commentView)
        bottomView.addSubview(shareView)
        bottomView.addSubview(viewsView)
        
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            bottomView.leftAnchor.constraint(equalTo: leftAnchor),
            bottomView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}

