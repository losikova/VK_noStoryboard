//
//  FriendsTableViewCell.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit

/// Передача индекса из ячейки в контроллер
protocol CustomTableViewCellProtocol: AnyObject {
    /// Срабатывает после нажатия на ячейку
    /// - Parameters:
    ///     - row: Индекс ячейки
    func performAfterTap(row: IndexPath)
}

protocol DidTapOnAvatarProtocol: AnyObject {
    func imagePressed()
}

final class CustomTableViewCell: UITableViewCell {
    
    // MARK: Public Properties
    static let identifier = "reusableIdentifierCustomTableViewCell"
    let avatarImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imagePressed))
        view.addGestureRecognizer(tap)
        return view
    }()
    var rowNumber = IndexPath()
    var delegate: CustomTableViewCellProtocol?
    
    // MARK: Private Properties
//    let friendsTableViewCell = UIView()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        return label
    }()
    
    // MARK: Init
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
 
// MARK: - Private SetupUI
private extension CustomTableViewCell {
        
    func setupUI() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = view.bounds.width / 2
        view.layer.shadowColor = UIColor.red.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        addSubview(nameLabel)
        addSubview(view)
        view.addSubview(avatarImageView)
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1),
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor, multiplier: 1),
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor),
            avatarImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            nameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16),
            nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8)
        ])
    }
    
}

// MARK: - Tap protocol
extension CustomTableViewCell: CustomTableViewCellProtocol {
    
    func performAfterTap(row: IndexPath) {
        delegate?.performAfterTap(row: row)
    }
}

// MARK: - Private Actions
private extension CustomTableViewCell {
    
    /// Получение картинки по ссылке
    func getImage(url: String) -> UIImage {
        let url = URL(string: url)!
        let imageData = try? Data(contentsOf: url)
        
        return UIImage(data: imageData!)!
    }
    
    /// Обработка нажатия на картинку
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
}
