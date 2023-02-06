//
//  ViewModel.swift
//  drodling
//
//  Created by Jørgen Faret on 05/02/2023.
//

import Foundation

@MainActor final class ViewModel {
    enum Event {
        enum State {
            case content(Person)
            case error(Error)
            case loading
        }

        case setState(State)
        case showAlert
        case dismiss
    }

    private let personProvider: PersonProviderProtocol

    private var continuation: AsyncStream<ViewModel.Event>.Continuation?

    init(personProvider: PersonProviderProtocol) {
        self.personProvider = personProvider
    }

    func subscribe() -> AsyncStream<Event> {
        return AsyncStream { continuation in
            self.continuation = continuation
        }
    }

    func loadPerson() async {
        continuation?.yield(.setState(.loading))
        do {
            let id = Int.random(in: 0..<100)
            let person = try await personProvider.getPerson(for: id)
            continuation?.yield(.setState(.content(person)))
        } catch {
            continuation?.yield(.setState(.error(error)))
        }
    }
}
