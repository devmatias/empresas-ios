//
//  SignInViewController.swift
//  empresas-ios
//
//  Created by Matias Correa Franco de Faria on 05/05/22.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {

    var uiController: SignInView
    
    init() {
        uiController = SignInView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = uiController
        setupAddTargetIsNotEmptyTextFields()
        navigationController?.navigationBar.barStyle = .black
    }

    override func viewDidLoad() {
        uiController.delegate = self
    }
    
    @objc func textFieldsIsNotEmpty(sender: UITextField) {
        guard let numberOfDigits = uiController.passwordField.text?.count else {
            return
        }
        if numberOfDigits >= 6 && uiController.emailField.text != "" {
            uiController.loginButton.isEnabled = true
        } else {
            uiController.loginButton.isEnabled = false
        }
    }

    func setupAddTargetIsNotEmptyTextFields() {
        uiController.emailField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
        uiController.passwordField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
    }

}

extension SignInViewController: SignInViewDelegate {
        
    func didTapSignInButton() {
        guard let email = uiController.emailField.text,
              let password = uiController.passwordField.text
               else {
            return
        }
        
        AuthRequisition.shared.signIn(with: email, password: password) { [weak self] result in
            switch result {
            case .success:
                let authRequisition = AuthRequisition.shared
                let homeVM = HomeViewModel(authRequisition: authRequisition)
                let homeVC = HomeViewController(viewModel: homeVM)
                self?.navigationController?.pushViewController(homeVC, animated: false)
            case .failure(let error):
                print(error)
                let alert = UIAlertController(
                    title: "Algo deu errado!",
                    message: "Verifique seu email e/ou senha e tente novamente.",
                    preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                print("Ainda sem erro")
                self?.present(alert, animated: true)
                self?.uiController.passwordField.text = nil
            }
        }
    }
}
