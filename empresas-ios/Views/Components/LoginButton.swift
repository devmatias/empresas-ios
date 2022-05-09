//
//  LoginButton.swift
//  empresas-ios
//
//  Created by Matias Correa Franco de Faria on 08/05/22.
//

import Foundation
import UIKit

class LoginButton: UIButton {
    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        backgroundColor = UIColor(red: 39.0/255.0, green: 16.0/255.0, blue: 25.0/255.0, alpha: 1)
        tintColor = .white
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        setTitle("ENTRAR", for: .normal)
        layer.cornerRadius = 26.0
        setBackgroundColor(color: UIColor(red: 138.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1), forState: .disabled)
    }
    
    private func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
