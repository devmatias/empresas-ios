//
//  SignInView.swift
//  empresas-ios
//
//  Created by Matias Correa Franco de Faria on 05/05/22.
//

import UIKit

protocol SignInViewDelegate: AnyObject {
    func didTapSignInButton()
}

public class SignInView: UIView {
    
    weak var delegate: SignInViewDelegate?
    
    var bgImage: UIImageView = {
        let background = "BG.png"
        let image = UIImage(named: background)
        let view = UIImageView(image: image!)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var bg1Label: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.text = "Boas vindas,"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var bg2Label: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 24, weight: .light)
        label.text = "Você está no Empresas."
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor(red: 39.0/255.0, green: 16.0/255.0, blue: 25.0/255.0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.text = "Digite seus dados para continuar."
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var emailField: UITextField = {
        let email = AuthField(type: .email)
        email.text = "testeapple@ioasys.com.br"
        return email
    }()
    
    var passwordField: UITextField = {
        let email = AuthField(type: .password)
        email.text = "12341234"
        return email
    }()
    
    let loginButton: LoginButton = {
        let button = LoginButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func didTapSignInButton() {
        delegate?.didTapSignInButton()
    }

}

extension SignInView: CodeView {
    func buildViewHierarchy() {
        addSubview(bgImage)
        addSubview(bg1Label)
        addSubview(bg2Label)
        addSubview(bottomView)
        addSubview(viewLabel)
        addSubview(emailField)
        addSubview(passwordField)
        addSubview(loginButton)
    }
    
    
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            bgImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bgImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bgImage.topAnchor.constraint(equalTo: self.topAnchor),
            bgImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bg1Label.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: bgImage.frame.size.height * 0.45),
            bg1Label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            bg1Label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -112),
        ])
        
        NSLayoutConstraint.activate([
            bg2Label.topAnchor.constraint(equalTo: bg1Label.bottomAnchor, constant: 0),
            bg2Label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            bg2Label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -112),
        ])
    
        NSLayoutConstraint.activate([
            bottomView.heightAnchor.constraint(
                equalToConstant: bgImage.frame.size.height * 0.45),
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            viewLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 0),
            viewLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            viewLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
        ])
        
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: viewLabel.bottomAnchor, constant: 16),
            emailField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            emailField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            emailField.heightAnchor.constraint(
                equalToConstant: 48),
        ])

        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 24),
            passwordField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            passwordField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            passwordField.heightAnchor.constraint(
                equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 32),
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -72)
        ])
        
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .systemBackground
    }
}
