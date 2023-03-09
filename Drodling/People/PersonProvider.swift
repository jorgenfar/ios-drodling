//
//  Provider.swift
//  drodling
//
//  Created by Jørgen Faret on 05/02/2023.
//

import Foundation

protocol PersonProviding {
    func getPerson(for id: Int) async throws -> Person
    func getPeople() async throws -> [Person]
}

final class PersonProvider: PersonProviding {
    private let urlPrefix = URL(string: "https://swapi.dev/api/people")!

    func getPerson(for id: Int) async throws -> Person {
        let url = urlPrefix.appending(path: "/\(id)")
        let request = Request(url: url)
        return try await request.execute()
    }

    func getPeople() async throws -> [Person] {
        let request = Request(url: urlPrefix)
        return try await request.execute()
    }
}
