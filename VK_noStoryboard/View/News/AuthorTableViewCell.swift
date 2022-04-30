//
//  AuthorTableViewCell.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 4/21/22.
//

import UIKit

class AuthorTableViewCell: UITableViewCell {
    
    static let identifier = "reuserIdentifierAuthor"
    
    var avatarView = AvatarView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), name: "", date: "")
    var avtor = String()
    var date = String()
    
    override func layoutIfNeeded() {
        setupUI()
        super.layoutIfNeeded()
    }

    override func awakeFromNib() {
        setupUI()
        super.awakeFromNib()
    }
    
    func setupUI() {
        avatarView = AvatarView(frame: CGRect(x: 0, y: 0, width: self.contentView.bounds.width, height: 60), name: avtor, date: date)
        self.contentView.addSubview(avatarView)
        self.contentView.layoutIfNeeded()
//        calculateRowHeight()
//        self.delegate?.setRowHeight(height: cellHeight)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.avtor = ""
        self.date = ""
        self.avatarView.removeFromSuperview()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
