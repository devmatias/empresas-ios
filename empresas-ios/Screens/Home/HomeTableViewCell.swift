//
//  HomeTableViewCell.swift
//  empresas-ios
//
//  Created by Matias Correa Franco de Faria on 03/05/22.
//

import UIKit
import Kingfisher

struct HomeTableViewCellViewModel {
    let enterprise_name: String
    let photo: String
    
    init(companie: Companies) {
        enterprise_name = companie.enterprise_name
        photo = companie.photo
    }
}

class HomeTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    var companyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var companyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }

    func setup(with viewModel: HomeTableViewCellViewModel, completion: @escaping ((UIImage) -> ())) {
        let path = "\(AuthRequisition.shared.basePath)\(viewModel.photo)"
        let resource = ImageResource(downloadURL: URL(fileURLWithPath: path))
        companyImage.kf.setImage(with: resource, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { result in
            switch result {
            case .success(let imageResult):
                completion(imageResult.image)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        companyLabel.text = viewModel.enterprise_name
    }
}

extension HomeTableViewCell: CodeView {
    func buildViewHierarchy() {
        addSubview(companyImage)
        addSubview(companyLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            companyImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            companyImage.heightAnchor.constraint(equalToConstant: 100),
            companyImage.topAnchor.constraint(equalTo: self.topAnchor),
            companyImage.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            companyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            companyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            companyLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
        ])
        
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .systemBackground
    }
    
    
}
