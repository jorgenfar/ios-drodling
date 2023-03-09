//
//  Extensions.swift
//  drodling
//
//  Created by Jørgen Faret on 05/02/2023.
//

import UIKit

extension Decodable {
    static func from(jsonData: Data) throws -> Self {
        return try JSONDecoder().decode(Self.self, from: jsonData)
    }
}

extension UIView {
    func addAutoLayoutSubView(_ child: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(child)
    }
}

extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .primaryActionTriggered, _ closure: @escaping () async ->  Void) {
        let action = UIAction { action in
            Task {
                await closure()
            }
        }
        addAction(action, for: controlEvents)
    }
}
