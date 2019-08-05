//
//  WebService.swift
//  challenge-ss
//
//  Created by Rafael Cadaval on 04/08/19.
//  Copyright © 2019 Rafael Cadaval. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case decodingError, domainError
}

struct Resource<T: Decodable> {
    let url: URL
}

class WebService {
    static func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }    
}
