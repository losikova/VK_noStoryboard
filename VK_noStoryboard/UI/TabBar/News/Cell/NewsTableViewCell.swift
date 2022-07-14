//
//  NewsTableViewCell.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 20.02.2022.
//

import UIKit

/// Передача высоты из ячейки во view controller
protocol NewsTableViewCellProtocol: AnyObject {
    /// Установитьт высоту ячейки
    func setRowHeight(_ height: CGFloat)
}

final class NewsTableViewCell: UITableViewCell {

    // MARK: Public properties
    static let identifier = "reuserIdentifierNews"
    var delegate: NewsTableViewCellProtocol?

    // MARK: Private properties
    private var avtor = String()
    private var date = String()
    private var inscriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.clipsToBounds = true
        return label
    }()
    private var photosView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    private var bottomView: UIView? = UIView(frame: .infinite)
    private var cellHeight = CGFloat()

    // MARK: Init
    override func prepareForReuse() {
        super.prepareForReuse()
        self.avtor = ""
        self.date = ""
        self.inscriptionLabel.text = ""
        self.photosView.image = nil
        bottomView = nil
    }
    
    /// Конфигурация новости
    /// - Parameters:
    ///     - avtor: Имя автора/ название группы
    ///     - date: Дата публикации
    ///     - inscription: Описание новости
    ///     - image: Картинка новости
    func configure(avtor: String, date: String, inscription: String, image: UIImage) {
        self.avtor = avtor
        self.date = date
        self.inscriptionLabel.text = inscription
        self.photosView.image = image
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - Private SetupUI
private extension NewsTableViewCell {
    
    func setup() {
        guard let bottomView = bottomView else { return }
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.clipsToBounds = true
        
        let avatarView = AvatarView(frame: CGRect(x: 0, y: 0, width: self.contentView.bounds.width, height: 60), name: avtor, date: date)
        
        addSubview(avatarView)
        addSubview(inscriptionLabel)
        addSubview(photosView)
        addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            inscriptionLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor),
            inscriptionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            inscriptionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])

        NSLayoutConstraint.activate([
            photosView.topAnchor.constraint(equalTo: inscriptionLabel.bottomAnchor),
            photosView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            photosView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            photosView.heightAnchor.constraint(equalTo: self.contentView.widthAnchor)
        ])

        let likesView = BottomItemView(item: .like)
        let commentView = BottomItemView(item: .comment)
        let shareView = BottomItemView(item: .share)
        let viewsView = BottomItemView(item: .views(width: self.bounds.width))

        bottomView.addSubview(likesView)
        bottomView.addSubview(commentView)
        bottomView.addSubview(shareView)
        bottomView.addSubview(viewsView)

        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: photosView.bottomAnchor),
            bottomView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            bottomView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            bottomView.heightAnchor.constraint(equalTo: likesView.heightAnchor)
        ])

        layoutIfNeeded()
        calculateRowHeight()
        delegate?.setRowHeight(cellHeight)
    }

}

// MARK: - Row Height
extension NewsTableViewCell: NewsTableViewCellProtocol {
    
    func setRowHeight(_ height: CGFloat) {
        delegate?.setRowHeight(cellHeight)
    }
    
    /// Подсчитать высоту ячейки
    private func calculateRowHeight() {
        var height = CGFloat(0)
        height += 60
        height += self.inscriptionLabel.bounds.height
        height += self.photosView.bounds.height
        height += bottomView!.bounds.height

        self.cellHeight = height
    }
}
