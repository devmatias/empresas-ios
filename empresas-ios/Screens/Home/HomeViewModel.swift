//
//  HomeViewModel.swift
//  empresas-ios
//
//  Created by Matias Correa Franco de Faria on 03/05/22.
//
import Foundation

class HomeViewModel {
    
    var companiesFound: (() -> ())?
    var companies: [Companies] = []
    private var apiClient = CompanyRequest()
    var searchText: String?
    var authRequisition: AuthRequisition

    
    init(authRequisition: AuthRequisition) {
        self.authRequisition = authRequisition
    }
    
    func searchCompanyByText() {
        guard let text = searchText else {
            return
        }
        apiClient.searchCompanyByText(text, authRequisition: authRequisition) { [weak self] result in
            switch result {
            case .success(let companies):
                self?.companies = companies
                self?.companiesFound?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
   
}
