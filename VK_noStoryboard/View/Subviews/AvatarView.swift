//
//  AvatarView.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 20.02.2022.
//

import UIKit

class AvatarView: UIView {
    
    private var photo = UIImageView()
    var name = UILabel()
    var date = UILabel()
    
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
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        setup()
    }
    
    func setup() {
        self.addSubview(photo)
        self.addSubview(name)
        self.addSubview(date)
        
        photo.image = UIImage(named: name.text!)
        photo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photo.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            photo.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            photo.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            photo.widthAnchor.constraint(equalTo: photo.heightAnchor)
        ])
        photo.contentMode = .scaleAspectFill
        photo.layer.cornerRadius = (self.bounds.height - 16) / 2
        photo.clipsToBounds = true
        
        name.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            name.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            name.leftAnchor.constraint(equalTo: photo.rightAnchor, constant: 16),
            name.bottomAnchor.constraint(equalTo: date.topAnchor, constant: -8)
        ])
        name.clipsToBounds = true
        
        date.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            date.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            date.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            date.leftAnchor.constraint(equalTo: photo.rightAnchor, constant: 16)
        ])
        date.clipsToBounds = true
    }
}

