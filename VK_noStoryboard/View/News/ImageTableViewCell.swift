//
//  ImageTableViewCell.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 4/24/22.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    static let identifier = "reuserIdentifierImage"
    
    var photosView = UIImageView()
    
    override func layoutIfNeeded() {
        setupUI()
        super.layoutIfNeeded()
    }

    override func awakeFromNib() {
        setupUI()
        super.awakeFromNib()
    }
    
    func setupUI() {
        self.contentView.addSubview(photosView)
        photosView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photosView.topAnchor.constraint(equalTo: self.topAnchor),
            photosView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            photosView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            photosView.heightAnchor.constraint(equalTo: self.contentView.widthAnchor)
        ])
        photosView.contentMode = .scaleAspectFill
        photosView.clipsToBounds = true
        
        self.contentView.layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photosView.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
