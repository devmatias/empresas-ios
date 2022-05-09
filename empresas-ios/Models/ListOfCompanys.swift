//
//  ListOfCompanys.swift
//  empresas-ios
//
//  Created by Matias Correa Franco de Faria on 03/05/22.
//

import Foundation
import UIKit


struct APIObjectResponse: Codable {
    var enterprises: Companies
}

struct APIListResponse: Codable {
    var enterprises: [Companies]
}

struct Companies: Codable {
    var enterprise_name: String
    var photo: String
    var description: String
}
