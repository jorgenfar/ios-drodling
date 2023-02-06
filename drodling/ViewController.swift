import UIKit
import SnapKit

final class ViewController: UIViewController {
    private let viewModel: ViewModel

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()

    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Refresh Person", for: .normal)
        return button
    }()

    init(viewModel: ViewModel) {
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
        view.addSubview(label)
        view.addSubview(button)
    }

    private func addConstraints() {
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        button.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }

    private func addTargets() {
        button.addAsyncAction { [weak self] in
            await self?.viewModel.loadPerson()
        }
    }
}

extension ViewController {
    private func subscribeToViewModel() {
        Task {
            for await event in viewModel.subscribe() {
                switch event {
                case .setState(let state):
                    switch state {
                    case .content(let person):
                        label.text = person.name
                    case .error(_):
                        label.text = "Failed to load person"
                    case .loading:
                        label.text = "Loading..."
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
