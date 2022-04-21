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

class BottomItemView: UIView {
    
    private var itemKind: bottomViewItem
    
    private var isLiked = false
    private var itemButton = UIButton()
    private var itemCounter = UILabel()
    
    init(item: bottomViewItem) {
        self.itemKind = item
        switch itemKind {
        case .like:
            super.init(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        case .comment:
            super.init(frame: CGRect(x: 60, y: 0, width: 40, height: 20))
        case .share:
            super.init(frame: CGRect(x: 120, y: 0, width: 40, height: 20))
        case .views(let width):
            super.init(frame: CGRect(x: width - 40, y: 0, width: 40, height: 20))
        }
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        self.itemKind = .like
        super.init(coder: coder)
        setup()
    }
    
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
        
        self.addSubview(itemCounter)
        itemCounter.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemCounter.heightAnchor.constraint(equalToConstant: 20),
            itemCounter.widthAnchor.constraint(equalToConstant: 20),
            itemCounter.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            itemCounter.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
        itemButton.clipsToBounds = true
        
        self.addSubview(itemButton)
        itemButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemButton.heightAnchor.constraint(equalToConstant: 20),
            itemButton.bottomAnchor.constraint(equalTo: itemCounter.bottomAnchor),
            itemButton.rightAnchor.constraint(equalTo: itemCounter.leftAnchor)
        ])
        itemButton.clipsToBounds = true
        
        
        itemButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
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

extension BottomItemView {
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

