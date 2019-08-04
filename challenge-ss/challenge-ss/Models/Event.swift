//
//  Event.swift
//  challenge-ss
//
//  Created by Rafael Cadaval on 04/08/19.
//  Copyright © 2019 Rafael Cadaval. All rights reserved.
//

import Foundation

struct Event: Decodable {
    let id: String
    let title: String
    let price: Double
    let latitude: StringOrDoubleTypeCase
    let longitude: StringOrDoubleTypeCase
    let image: String
    let description: String
    let date: Int
    
    // TODO: Implement 'people' array and 'cupons' later on, when some doubts are cleared
}

enum StringOrDoubleTypeCase: Codable {
    case double(Double)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(StringOrDoubleTypeCase.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for StringOrDoubleTypeCase"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
