//
//  LoginView+.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit

extension LoginView {
    
    @objc func loginButtonPressed(_ sender: UIButton) {
        let login = self.loginInputView.loginInput.text!
        let password = self.loginInputView.passwordInput.text!
        let session = Session.instance

        // Проверяем, верны ли они
        if login == "Admin" && password == "123456" {
            print("успешная авторизация")
            self.loadingView.animateLoading(.start)
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
                let succesfullNotification = Notification.Name("succesfullEnter")
                NotificationCenter.default.post(name: succesfullNotification, object: nil)
                session.token = "23ef324feoih039inw"
                session.userId = 1232132
            })
    
        } else {
            let loginErrorNotification = Notification.Name("loginError")
            NotificationCenter.default.post(name: loginErrorNotification, object: nil)
            print("ошибка авторизации")
        }
    }
    
    @objc func inputCheck(notification: Notification) {
        let onTitleColor = #colorLiteral(red: 0.1019607843, green: 0.09803921569, blue: 0.1019607843, alpha: 1)
        let offTitleColor = #colorLiteral(red: 0.636711657, green: 0.6127592325, blue: 0.6415295601, alpha: 1)
        
        if self.loginInputView.loginInput.text != "" && self.loginInputView.passwordInput.text != "" {
            loginButton.isEnabled = true
            loginButton.setTitleColor(onTitleColor, for: .normal)
        } else {
            loginButton.isEnabled = false
            loginButton.setTitleColor(offTitleColor, for: .normal)
        }
    }
    
}
