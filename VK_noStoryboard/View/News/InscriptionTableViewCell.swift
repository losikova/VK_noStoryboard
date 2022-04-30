//
//  InscriptionTableViewCell.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 4/24/22.
//

import UIKit

class InscriptionTableViewCell: UITableViewCell {
    
    static let identifier = "reuserIdentifierInscription"
    
    var inscriptionLabel = UILabel()
    
//    var delegate: NewsTableViewCellProtocol?
//    private var cellHeight = CGFloat()
    
    override func layoutIfNeeded() {
        setupUI()
        super.layoutIfNeeded()
    }

    override func awakeFromNib() {
        setupUI()
        super.awakeFromNib()
    }
    
    func setupUI() {
        self.contentView.addSubview(inscriptionLabel)
        inscriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inscriptionLabel.topAnchor.constraint(equalTo: self.topAnchor),
            inscriptionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            inscriptionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
        inscriptionLabel.numberOfLines = 3
        inscriptionLabel.clipsToBounds = true
        
        self.contentView.layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.inscriptionLabel.text = ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
