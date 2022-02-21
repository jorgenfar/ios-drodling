import UIKit
import SnapKit

final class ViewController: UIViewController {

    var timer: Timer?
    var progress: CGFloat = 0

    private let testView: ProgressView = {
        let view = ProgressView()
        view.backgroundColor = .clear
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        addViews()
        addConstraints()

        Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(updateProgress),
            userInfo: nil,
            repeats: true
        )
    }

    private func addViews() {
        view.addSubview(testView)
    }

    private func addConstraints() {
        testView.snp.makeConstraints { make in
            make.height.width.equalTo(200)
            make.center.equalToSuperview()
        }
    }

    @objc private func updateProgress() {
        let diff = CGFloat(Float.random(in: 0..<0.01))
        let sum = progress + diff
        if sum < 1 {
            progress = sum
            testView.state = ProgressView.State(progress: progress)
        } else {
            timer?.invalidate()
        }
    }
}
