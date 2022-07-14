//
//  LoadingView.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit

final class LoadingView: UIView {

    // MARK: Properties
    enum Animate {
        case start
        case stop
    }
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

// MARK: - Private SetupUI
private extension LoadingView {
    
    func setupUI() {
        self.backgroundColor = .clear
        
        let dot1 = UIView()
        let dot2 = UIView()
        let dot3 = UIView()
        
        dot1.translatesAutoresizingMaskIntoConstraints = false
        dot2.translatesAutoresizingMaskIntoConstraints = false
        dot3.translatesAutoresizingMaskIntoConstraints = false
        
        dot1.clipsToBounds = true
        dot2.clipsToBounds = true
        dot3.clipsToBounds = true
        
        dot1.backgroundColor = .black
        dot2.backgroundColor = .black
        dot3.backgroundColor = .black
        
        addSubview(dot1)
        addSubview(dot2)
        addSubview(dot3)
        
        NSLayoutConstraint.activate([
            dot2.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dot2.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dot2.widthAnchor.constraint(equalToConstant: 20),
            dot2.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            dot1.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -30),
            dot1.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dot1.widthAnchor.constraint(equalToConstant: 20),
            dot1.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            dot3.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 30),
            dot3.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dot3.widthAnchor.constraint(equalToConstant: 20),
            dot3.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        dot1.layoutIfNeeded()
        dot2.layoutIfNeeded()
        dot3.layoutIfNeeded()
        
        dot1.layer.cornerRadius = dot1.bounds.height / 2
        dot2.layer.cornerRadius = dot2.bounds.height / 2
        dot3.layer.cornerRadius = dot3.bounds.height / 2

        isHidden = true
    }
}

// MARK: - Animation
extension LoadingView {
    
    /// Анимация загрузки
    func animateLoading(_ animate: Animate) {
        isHidden = false
        
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0.1
        animation.toValue = 1
        animation.duration = 0.3
        animation.repeatDuration = .infinity
        animation.autoreverses = true
        
        switch animate {
        case .start:
            self.isHidden = false
            self.subviews[1].layer.add(animation, forKey: nil)
            animation.beginTime = CACurrentMediaTime() + 0.1
            self.subviews[0].layer.add(animation, forKey: nil)
            animation.beginTime = CACurrentMediaTime() + 0.2
            self.subviews[2].layer.add(animation, forKey: nil)
        case .stop:
            self.subviews[1].layer.removeAllAnimations()
            self.subviews[0].layer.removeAllAnimations()
            self.subviews[2].layer.removeAllAnimations()
            self.isHidden = true
        }
    }
}
