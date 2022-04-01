//
//  FriendsTableViewCell.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit

protocol CustomTableViewCellProtocol: AnyObject {
    func performAfterTap(row: IndexPath)
}

protocol DidTapOnAvatarProtocol: AnyObject {
    func imagePressed()
}

class CustomTableViewCell: UITableViewCell {
    
//    let friendsTableViewCell = UIView()
    let avatarImageView = UIImageView()
    let nameLabel = UILabel()
    
    static let identifier = "reusableIdentifierCustomTableViewCell"     //почему static
    
    var delegate: CustomTableViewCellProtocol?
    var rowNumber = IndexPath()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        nameLabel.text = nil
    }
    
    func configure(friend: Friend) {
        avatarImageView.image = getImage(url: friend.avatar)
        nameLabel.text = "\(friend.firstName) \(friend.lastName)"
        setupUI()
    }
    
    func configure(group: Group) {
        avatarImageView.image = getImage(url: group.avatar)
        nameLabel.text = group.name
        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func getImage(url: String) -> UIImage {
        let url = URL(string: url)!
        let imageData = try? Data(contentsOf: url)
        
        return UIImage(data: imageData!)!
    }
    
    @objc func imagePressed() {
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
                       completion: { _ in
            self.delegate?.performAfterTap(row: self.rowNumber)
        })
    }
    
    private func setupUI() {
        let view = UIView()
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1),
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        view.layer.cornerRadius = view.bounds.width / 2
        view.layer.shadowColor = UIColor.red.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        view.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor, multiplier: 1),
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor),
            avatarImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        avatarImageView.clipsToBounds = true
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imagePressed))
        avatarImageView.addGestureRecognizer(tap)
        
        
        contentView.addSubview(nameLabel)
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
    func performAfterTap(row: IndexPath) {
        delegate?.performAfterTap(row: row)
    }
}
