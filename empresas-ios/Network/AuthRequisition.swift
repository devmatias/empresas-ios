//
//  AuthRequisition.swift
//  empresas-ios
//
//  Created by Matias Correa Franco de Faria on 05/05/22.
//

import Foundation

enum APIError: Error {
    case responseProblem
    case decodingProblem
    case otherProblem
}

class AuthRequisition {
    public static let shared = AuthRequisition()
    let basePath = "https://empresas.ioasys.com.br"
    let session = URLSession(configuration: .default)
    var clientHeader = ""
    var accessTokenHeader = ""
    var uidHeader = ""
    
    public func signIn(with email: String, password: String, completion: @escaping (Result<AuthObjectResponse, APIError>) -> Void) {
        guard let resourceURL = URL(string: "\(basePath)/api/v1/users/auth/sign_in" ) else {
            return
        }
        
        var json = [String:String]()
        json["email"] = email
        json["password"] = password
        
        let data = try! JSONSerialization.data(withJSONObject: json, options: [])
        var request = URLRequest(url: resourceURL)
        request.httpMethod = "POST"
        request.httpBody = data
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { [self] data, response, _ in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                completion(.failure(.responseProblem))
                return
            }
            
            self.clientHeader = httpResponse.value(forHTTPHeaderField: "client") ?? " header not found"
            self.accessTokenHeader = httpResponse.value(forHTTPHeaderField: "access-token") ?? " header not found"
            self.uidHeader = httpResponse.value(forHTTPHeaderField: "uid") ?? " header not found"
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                
                let response = try decoder.decode(AuthObjectResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(response))
                }
                
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodingProblem))
                }
            }
   
        }
        task.resume()
    }
}
