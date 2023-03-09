import UIKit
import TinyConstraints

final class PeopleViewController: UIViewController {
    private let viewModel: PeopleViewModel

    private let card = PersonCard()

    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Refresh Person", for: .normal)
        return button
    }()

    init(viewModel: PeopleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        subscribeToViewModel()
        addViews()
        addConstraints()
        addTargets()
    }

    private func addViews() {
        view.addSubview(card)
        view.addSubview(button)
    }

    private func addConstraints() {
        card.center(in: view)
        
        button.topToBottom(of: card, offset: 20)
        button.centerXToSuperview()
    }

    private func addTargets() {
        button.addAction { [weak self] in
            await self?.viewModel.loadPerson()
        }
    }
}

extension PeopleViewController {
    private func subscribeToViewModel() {
        Task {
            for await event in viewModel.subscribe() {
                switch event {
                case .setState(let state):
                    switch state {
                    case .content(let person):
                        card.set(person: person)
                    case .error(_):
                        break
                    case .loading:
                        card.set(person: nil)
                    }
                case .showAlert:
                    break
                case .dismiss:
                    break
                }
            }
        }
    }
}
