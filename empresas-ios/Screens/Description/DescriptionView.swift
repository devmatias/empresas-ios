//
//  DescriptionView.swift
//  empresas-ios
//
//  Created by Matias Correa Franco de Faria on 03/05/22.
//

import UIKit

class DescriptionView: UIView {

    var companyImage: UIImageView = {
        let image = UIImage(named: "_Placeholder")
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFill
        view.backgroundColor = UIColor(red: 17.0/255.0, green: 17.0/255.0, blue: 17.0/255.0, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var secondLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 16)
        view.text = "Description"
        view.numberOfLines = 100
        view.textAlignment = .justified
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DescriptionView: CodeView {
    func buildViewHierarchy() {
        addSubview(companyImage)
        addSubview(secondLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            secondLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            secondLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            secondLabel.topAnchor.constraint(equalTo: companyImage.bottomAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            companyImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            companyImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            companyImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            companyImage.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .systemBackground
    }
}
