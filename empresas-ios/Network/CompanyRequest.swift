//
//  APIRequest.swift
//  empresas-ios
//
//  Created by Matias Correa Franco de Faria on 05/05/22.
//

import Foundation

struct CompanyRequest {
    
    let basePath = "https://empresas.ioasys.com.br/api/v1/"
    let session: URLSession = URLSession(configuration: .default)
    
    public func searchCompanyByText(_ text: String, authRequisition: AuthRequisition, completion: @escaping (_ result: Result<[Companies], APIError>) -> Void) {
        guard let requestURL = URL(string: "\(basePath)enterprises?name=\(text)") else {
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(authRequisition.accessTokenHeader, forHTTPHeaderField: "access-token")
        request.addValue(authRequisition.clientHeader, forHTTPHeaderField: "client")
        request.addValue(authRequisition.uidHeader, forHTTPHeaderField: "uid")
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                completion(.failure(APIError.responseProblem))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                
                let response = try decoder.decode(APIListResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(response.enterprises))
                }
                
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(APIError.decodingProblem))
                }
            }
        }
        task.resume()
    }
}

