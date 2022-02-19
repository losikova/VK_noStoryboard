//
//  FriendsTableViewCell.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit

protocol CustomTableViewCellProtocol: AnyObject {
    func performSegueAfterTap(row: IndexPath)
}

class CustomTableViewCell: UITableViewCell {
    
//    let friendsTableViewCell = UIView()
    let avatarImageView: UIImageView = {
        let image = UIImageView()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imagePressed(_:)))
        image.addGestureRecognizer(tapRecognizer)
        return image
    }()
    let nameLabel = UILabel()
    
    static let identifier = "reusableIdentifierCustomTableViewCell"     //почему static
    
    var delegate: CustomTableViewCellProtocol?
    var rowNumber = IndexPath()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        nameLabel.text = nil
    }
    
    func configure(friend: User) {
        avatarImageView.image = friend.avatar
        nameLabel.text = friend.name
        setupUI()
    }
    
    func configure(group: Group) {
        avatarImageView.image = group.icon
        nameLabel.text = group.name
        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
    }
    
    @objc func imagePressed(_ sender: UIView) {
        let scale: CGFloat = 20
        let frame = avatarImageView.frame
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 0.1,
                       options: [],
                       animations: {
            self.avatarImageView.frame = CGRect(x: frame.origin.x - scale/2, y: frame.origin.y - scale/2, width: frame.width + scale, height: frame.height + scale)
        },
                       completion: {_ in
            self.delegate?.performSegueAfterTap(row: self.rowNumber)
        })
    }
    
    private func setupUI() {
        addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor, multiplier: 1),
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            avatarImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            avatarImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        avatarImageView.clipsToBounds = true
        avatarImageView.contentMode = .scaleAspectFill
        
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            nameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16),
            nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8)
        ])
        nameLabel.clipsToBounds = true
    }
    
}

extension CustomTableViewCell: CustomTableViewCellProtocol {
    func performSegueAfterTap(row: IndexPath) {
        delegate?.performSegueAfterTap(row: row)
    }
    
    
}
