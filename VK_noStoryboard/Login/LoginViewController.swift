//
//  LoginViewController.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.1019607843, alpha: 1)
        
        let loginErrorNotification = Notification.Name("loginError")
        NotificationCenter.default.addObserver(self, selector: #selector(loginError(notification:)), name: loginErrorNotification, object: nil)
        let succesfullNotification = Notification.Name("succesfullEnter")
        NotificationCenter.default.addObserver(self, selector: #selector(succesfullEnter(notification:)), name: succesfullNotification, object: nil)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        self.view.addGestureRecognizer(tapRecognizer)
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(loginView)
        loginView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginView.leftAnchor.constraint(equalTo: view.leftAnchor),
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.rightAnchor.constraint(equalTo: view.rightAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        loginView.clipsToBounds = true
    }
    
    @objc func tapFunction() {
        self.view.endEditing(true)
    }
    
    deinit {
        let loginErrorNotification = Notification.Name("loginError")
        let succesfullNotification = Notification.Name("succesfulEnter")
        NotificationCenter.default.removeObserver(self, name: loginErrorNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: succesfullNotification, object: nil)
    }
}
