//
//  AuthField.swift
//  empresas-ios
//
//  Created by Matias Correa Franco de Faria on 05/05/22.
//

import UIKit

class AuthField: UITextField {

    enum FieldType {
        case email
        case password
        
        var title: String {
            switch self {
            case .email: return "  Email"
            case .password: return "  Senha"
            }
        }
    }
    
    private let type: FieldType
    
    init(type: FieldType) {
        self.type = type
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureUI () {
        autocapitalizationType = .none
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 8
        layer.masksToBounds = true
        placeholder = type.title
        leftViewMode = .always
        returnKeyType = .done
        autocorrectionType = .no
        
        if type == .password {
            textContentType = .oneTimeCode
            isSecureTextEntry = true
        }
        else if type == .email {
            keyboardType = .emailAddress
            textContentType = .emailAddress
        }
    }
    
}
