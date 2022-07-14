//
//  AvatarView.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 20.02.2022.
//

import UIKit

final class AvatarView: UIView {
    
    // MARK: Private Properties
    private var photo: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    // MARK: Public Properties
    var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        return label
    }()
    var date: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        return label
    }()
    
    // MARK: Init
    init(frame: CGRect, name: String, date: String){
        super.init(frame: frame)
        self.name.text = name
        self.date.text = date
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
}

// MARK: - Private SetupUI
private extension AvatarView {
    
    func setup() {
        self.addSubview(photo)
        self.addSubview(name)
        self.addSubview(date)
        
        NSLayoutConstraint.activate([
            photo.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            photo.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            photo.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            photo.widthAnchor.constraint(equalTo: photo.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            name.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            name.leftAnchor.constraint(equalTo: photo.rightAnchor, constant: 16),
            name.bottomAnchor.constraint(equalTo: date.topAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            date.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            date.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            date.leftAnchor.constraint(equalTo: photo.rightAnchor, constant: 16)
        ])
        
        photo.image = UIImage(named: name.text!)
        layoutIfNeeded()
        photo.layer.cornerRadius = (self.bounds.height - 16) / 2
    }
}
