//
//  Provider.swift
//  drodling
//
//  Created by Jørgen Faret on 05/02/2023.
//

import Foundation

protocol PersonProviderProtocol {
    func getPerson(for id: Int) async throws -> Person
}

final class PersonProvider: PersonProviderProtocol {
    private let session = URLSession(configuration: .ephemeral)

    func getPerson(for id: Int) async throws -> Person {
        let url = URL(string: "https://swapi.dev/api/people/\(id)")!
        let request = URLRequest(url: url)
        let (data, _) = try await session.data(for: request)
        return try Person.from(data: data)
    }
}
