//
//  Person.swift
//  drodling
//
//  Created by Jørgen Faret on 05/02/2023.
//

import Foundation

struct Person {
    let name: String
    let height: Int
    let mass: Int
}

extension Person: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case height
        case mass
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)

        guard let heightInt = try Int(values.decode(String.self, forKey: .height)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.height], debugDescription: ""))
        }
        guard let massInt = try Int(values.decode(String.self, forKey: .mass)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.mass], debugDescription: ""))
        }

        height = heightInt
        mass = massInt
    }
}
