//
//  AuthResponse.swift
//  empresas-ios
//
//  Created by Matias Correa Franco de Faria on 06/05/22.
//

import Foundation

struct AuthObjectResponse: Codable {
    var investor: AuthResponse
}

struct AuthResponse: Codable {
    var email: String
}
