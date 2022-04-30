//
//  BottomTableViewCell.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 4/24/22.
//

import UIKit

class BottomTableViewCell: UITableViewCell {
    
    static let identifier = "reuserIdentifierBottom"
    
    private var bottomView: UIView? = UIView(frame: .infinite)
    
    override func layoutIfNeeded() {
        setupUI()
        super.layoutIfNeeded()
    }

    override func awakeFromNib() {
        setupUI()
        super.awakeFromNib()
    }
    
    func setupUI() {
        guard let bottomView = bottomView else {return}
        
        let likesView = BottomItemView(item: .like)
        let commentView = BottomItemView(item: .comment)
        let shareView = BottomItemView(item: .share)
        let viewsView = BottomItemView(item: .views(width: self.bounds.width))

        bottomView.addSubview(likesView)
        bottomView.addSubview(commentView)
        bottomView.addSubview(shareView)
        bottomView.addSubview(viewsView)

        self.contentView.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: self.topAnchor),
            bottomView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            bottomView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            bottomView.heightAnchor.constraint(equalTo: likesView.heightAnchor)
        ])
        bottomView.clipsToBounds = true
        
        self.contentView.layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bottomView = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
