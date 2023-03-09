//
//  Card.swift
//  drodling
//
//  Created by jorgen.faret@vipps.no on 09/03/2023.
//

import UIKit
import SkeletonView

class PersonCard: UIView {
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .headline)
        view.numberOfLines = 1
        view.isSkeletonable = true
        return view
    }()

    private let massLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .body)
        view.numberOfLines = 1
        view.isSkeletonable = true
        return view
    }()

    private let heightLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .body)
        view.numberOfLines = 1
        view.isSkeletonable = true
        return view
    }()

    private var labels: [UILabel] {
        return [nameLabel, massLabel, heightLabel]
    }

    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: labels)
        view.axis = .vertical
        view.spacing = 12

        return view
    }()

    init() {
        super.init(frame: .zero)
        layer.cornerRadius = 8

        backgroundColor = .white
        addAutoLayoutSubView(stackView)

        width(280)

        stackView.edgesToSuperview(insets: .uniform(20))
    }

    func set(person: Person?) {
        set(isLoading: person == nil)
        nameLabel.text = person?.name ?? ""
        massLabel.text = person?.mass.description ?? ""
        heightLabel.text = person?.height.description ?? ""
    }

    private func set(isLoading: Bool) {
        labels.forEach {
            if isLoading {
                $0.showSkeleton()
            } else {
                $0.hideSkeleton()
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
