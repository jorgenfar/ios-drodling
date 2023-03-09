//
//  HTTPClient.swift
//  drodling
//
//  Created by jorgen.faret@vipps.no on 09/03/2023.
//

import Foundation

struct Request {
    enum Verb: String {
        case get
        case put
        case post
        case delete
    }

    let url: URL
    let verb: Verb

    private let session = URLSession(configuration: .default)

    init(url: URL, verb: Verb = .get) {
        self.url = url
        self.verb = verb
    }

    func execute<T: Decodable>() async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = verb.rawValue
        let (data, _) = try await session.data(for: request)
        return try T.from(jsonData: data)
    }
}
