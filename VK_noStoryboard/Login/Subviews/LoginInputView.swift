//
//  LoginInputView.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//

import UIKit

class LoginInputView: UIView {
    
    let loginInput: UITextField = {
        let login = UITextField()
        login.attributedPlaceholder = NSAttributedString(string: "Phone or email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.45, green: 0.46, blue: 0.47, alpha: 1.00)])
        login.borderStyle = .none
        login.textAlignment = .center
        login.textColor = .white
        login.backgroundColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
        login.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        return login
    }()
    
    let passwordInput: UITextField = {
        let password = UITextField()
        password.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.45, green: 0.46, blue: 0.47, alpha: 1.00)])
        password.borderStyle = .none
        password.textAlignment = .center
        password.textColor = .white
        password.backgroundColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
        password.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        password.addTarget(self, action: #selector(passwordClicked), for: .editingDidBegin)
        password.addTarget(self, action: #selector(passwordEditingDidEnd), for: .editingDidEnd)
        return password
    }()
    
    private let passwordEye: UIButton = {
        let eye = UIButton()
        eye.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        eye.tintColor = UIColor(red: 0.45, green: 0.46, blue: 0.47, alpha: 1.00)
        eye.isHidden = true
        eye.addTarget(self, action: #selector(eyeClicked), for: .touchUpInside)
        return eye
    }()
    
    var eyeSlashed = true
    
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
    
    private func setupUI() {
        self.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.2352941176, blue: 0.2431372549, alpha: 1)
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.23, green: 0.24, blue: 0.24, alpha: 1.00).cgColor
        
        addSubview(loginInput)
        addSubview(passwordInput)
        addSubview(passwordEye)
        
        contraintPrepare(loginInput)
        contraintPrepare(passwordInput)
        contraintPrepare(passwordEye)
        
        NSLayoutConstraint.activate([
            loginInput.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 1),
            loginInput.topAnchor.constraint(equalTo: self.topAnchor, constant: 1),
            loginInput.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -1),
            loginInput.bottomAnchor.constraint(equalTo: passwordInput.topAnchor, constant: -1),
            loginInput.widthAnchor.constraint(equalToConstant: 350),
            loginInput.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            passwordInput.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 1),
            passwordInput.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1),
            passwordInput.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -1),
            passwordInput.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            passwordEye.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            passwordEye.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            passwordEye.widthAnchor.constraint(equalToConstant: 52),
            passwordEye.heightAnchor.constraint(equalToConstant: 31)
        ])
    }
    
    @objc private func textFieldChanged() {
        let textChangedNotification = Notification.Name("textChanged")
        NotificationCenter.default.post(name: textChangedNotification, object: nil)
    }
    
    @objc private func passwordClicked() {
        passwordEye.isHidden = false
        passwordInput.isSecureTextEntry = true
    }
    
    @objc private func eyeClicked() {
        if eyeSlashed {
            passwordEye.setImage(UIImage(systemName: "eye"), for: .normal)
            passwordInput.isSecureTextEntry = false
            eyeSlashed.toggle()
        } else {
            passwordEye.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            passwordInput.isSecureTextEntry = true
            eyeSlashed.toggle()
        }
    }
    
    @objc private func passwordEditingDidEnd() {
        passwordEye.isHidden = true
        passwordInput.isSecureTextEntry = true
        passwordEye.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        eyeSlashed = true
    }

}
