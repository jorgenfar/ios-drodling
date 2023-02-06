//
//  Extensions.swift
//  drodling
//
//  Created by Jørgen Faret on 05/02/2023.
//

import UIKit

extension Decodable {
    static func from(data: Data) throws -> Self {
        return try JSONDecoder().decode(Self.self, from: data)
    }
}

extension UIView {
    func addAutoLayoutSubView(_ child: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(child)
    }
}

extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .primaryActionTriggered, _ closure: @escaping () -> Void) {
        addAction(UIAction { (action: UIAction) in closure() }, for: controlEvents)
    }

    func addAsyncAction(for controlEvents: UIControl.Event = .primaryActionTriggered, _ closure: @escaping () async ->  Void) {
        let action = UIAction { action in
            Task {
                await closure()
            }
        }
        addAction(action, for: controlEvents)
    }
}
