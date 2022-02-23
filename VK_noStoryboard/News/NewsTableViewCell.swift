//
//  NewsTableViewCell.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 20.02.2022.
//

import UIKit

protocol NewsTableViewCellProtocol: AnyObject {
    func setRowHeight(height: CGFloat)
}

class NewsTableViewCell: UITableViewCell {

    static let identifier = "reuserIdentifierNews"

    var avtor = String()
    var date = String()
    var inscriptionLabel = UILabel()
    var photosView = UIImageView()
    private var bottomView: UIView? = UIView(frame: .infinite)

    var delegate: NewsTableViewCellProtocol?
    private var cellHeight = CGFloat()

    override func layoutIfNeeded() {
        setup()
        super.layoutIfNeeded()
    }

    override func awakeFromNib() {
        setup()
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.avtor = ""
        self.date = ""
        self.inscriptionLabel.text = ""
        self.photosView.image = nil
        bottomView = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup() {
        guard let bottomView = bottomView else {return}

        
        let avatarView = AvatarView(frame: CGRect(x: 0, y: 0, width: self.contentView.bounds.width, height: 60), name: avtor, date: date)
        self.contentView.addSubview(avatarView)

        self.contentView.addSubview(inscriptionLabel)
        inscriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inscriptionLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor),
            inscriptionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            inscriptionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
        inscriptionLabel.numberOfLines = 3
        inscriptionLabel.clipsToBounds = true

        self.contentView.addSubview(photosView)
        photosView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photosView.topAnchor.constraint(equalTo: inscriptionLabel.bottomAnchor),
            photosView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            photosView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            photosView.heightAnchor.constraint(equalTo: self.contentView.widthAnchor)
        ])
        photosView.contentMode = .scaleAspectFill
        photosView.clipsToBounds = true

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
            bottomView.topAnchor.constraint(equalTo: photosView.bottomAnchor),
            bottomView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            bottomView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            bottomView.heightAnchor.constraint(equalTo: likesView.heightAnchor)
        ])
        bottomView.clipsToBounds = true

        self.contentView.layoutIfNeeded()
        calculateRowHeight()
        self.delegate?.setRowHeight(height: cellHeight)
    }

}

extension NewsTableViewCell: NewsTableViewCellProtocol {
    func setRowHeight(height: CGFloat) {
        delegate?.setRowHeight(height: cellHeight)
    }

    private func calculateRowHeight() {
        var height = CGFloat(0)
        height += 60
        height += self.inscriptionLabel.bounds.height
        height += self.photosView.bounds.height
        height += bottomView!.bounds.height

        self.cellHeight = height
    }
}
