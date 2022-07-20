//
//  BottomViewItem.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 20.02.2022.
//

import UIKit

enum bottomViewItem {
    case like
    case comment
    case share
    case views(width: CGFloat)
}

final class BottomItemView: UIView {
    
    // MARK: Private Properties
    private var itemKind: bottomViewItem
    private var itemButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    private var itemCounter: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        return label
    }()
    private var isLiked = false
    
    // MARK: Init
    init(item: bottomViewItem) {
        self.itemKind = item
        switch itemKind {
        case .like:
            super.init(frame: CGRect(x: 10, y: 8, width: 40, height: 20))
        case .comment:
            super.init(frame: CGRect(x: 70, y: 8, width: 40, height: 20))
        case .share:
            super.init(frame: CGRect(x: 130, y: 8, width: 40, height: 20))
        case .views(let width):
            super.init(frame: CGRect(x: width - 40, y: 8, width: 40, height: 20))
        }
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        self.itemKind = .like
        super.init(coder: coder)
        setup()
    }
}

// MARK: - Private SetupUI
private extension BottomItemView {
    
    func setup() {
        itemButton.tintColor = UIColor(red: 0.45, green: 0.46, blue: 0.47, alpha: 1.00)
        itemCounter.tintColor = UIColor(red: 0.45, green: 0.46, blue: 0.47, alpha: 1.00)
        
        switch itemKind {
        case .like:
            itemButton.setImage(UIImage(systemName: "heart"), for: .normal)
            itemCounter.text = "0"
        case .comment:
            itemButton.setImage(UIImage(systemName: "bubble.left"), for: .normal)
            itemCounter.text = "10"
        case .share:
            itemButton.setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
            itemCounter.text = "3"
        case .views:
            itemButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            itemCounter.text = "6"
        }
        
        addSubview(itemCounter)
        addSubview(itemButton)
        
        NSLayoutConstraint.activate([
            itemCounter.heightAnchor.constraint(equalToConstant: 20),
            itemCounter.widthAnchor.constraint(equalToConstant: 20),
            itemCounter.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            itemCounter.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            itemButton.heightAnchor.constraint(equalToConstant: 20),
            itemButton.bottomAnchor.constraint(equalTo: itemCounter.bottomAnchor),
            itemButton.rightAnchor.constraint(equalTo: itemCounter.leftAnchor)
        ])
    }
}

// MARK: - Private Actions
private extension BottomItemView {
    
    /// Нажата кнопка view
    @objc func buttonTapped() {
        switch itemKind {
        case .like:
            likeAnimation(isLiked: self.isLiked)
            if isLiked {
                itemButton.setImage(UIImage(systemName: "heart"), for: .normal)
                itemButton.tintColor = UIColor(red: 0.45, green: 0.46, blue: 0.47, alpha: 1.00)
                self.isLiked.toggle()
                
            } else {
                itemButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                itemButton.tintColor = .red
                self.isLiked.toggle()
            }
        case .comment:
            print("comment tapped")
        case .share:
            print("share tapped")
        case .views:
            print("views tapped")
        }
        
    }
    
}

// MARK: - Private Animation
private extension BottomItemView {
    
    ///Анимация лайка
    /// - Parameters:
    ///    - isLiked: Лайкнули / Убрали лайк
    func likeAnimation(isLiked: Bool) {
        UIView.transition(with: itemCounter,
                          duration: 1,
                          options: .transitionFlipFromTop,
                          animations: {
            if isLiked {
                self.itemCounter.text = String(Int(self.itemCounter.text!)! - 1)
            } else {
                self.itemCounter.text = String(Int(self.itemCounter.text!)! + 1)
            }
        })
    }
}

