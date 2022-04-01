//
//  LoginView.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit

class LoginView: UIView {

    private let logoImageView: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        return logo
    }()
    
    let loginInputView = LoginInputView()
    
    let loginButton: UIButton = {
        let button = UIButton()
        let titleColor = #colorLiteral(red: 0.636711657, green: 0.6127592325, blue: 0.6415295601, alpha: 1)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.setTitle("Sing In", for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.isEnabled = false
        button.addTarget(LoginView.self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let loadingView = LoadingView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func contraintPrepare(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
    }
    
    private func setupUI(){
        let textChangedNotification = Notification.Name("textChanged")
        NotificationCenter.default.addObserver(self, selector: #selector(inputCheck(notification:)), name: textChangedNotification, object: nil)
        
        addSubview(logoImageView)
        contraintPrepare(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 110),
            logoImageView.heightAnchor.constraint(equalToConstant: 90),
            logoImageView.widthAnchor.constraint(equalToConstant: 90)
        ])
        
        addSubview(loginInputView)
        contraintPrepare(loginInputView)
        NSLayoutConstraint.activate([
            loginInputView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginInputView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40)
        ])
        
        addSubview(loginButton)
        contraintPrepare(loginButton)
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: loginInputView.bottomAnchor, constant: 40),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            loginButton.widthAnchor.constraint(equalToConstant: 350)
        ])
        
        addSubview(loadingView)
        contraintPrepare(loadingView)
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 60),
            loadingView.heightAnchor.constraint(equalToConstant: 60),
            loadingView.widthAnchor.constraint(equalToConstant: 240)
        ])
    }
    
    deinit {
        let textChangedNotification = Notification.Name("textChanged")
        NotificationCenter.default.removeObserver(self, name: textChangedNotification, object: nil)
    }
    
}
