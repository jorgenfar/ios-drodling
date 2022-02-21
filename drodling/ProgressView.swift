import UIKit

final class ProgressView: UIView {

    struct State {
        let progress: CGFloat
    }

    var state: State? {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        guard let state = state, let context = UIGraphicsGetCurrentContext() else { return }

        let startAngle = -90.degreesToRadians
        let endAngle = startAngle + state.progress * 360.degreesToRadians

        let center = CGPoint(x: rect.width/2, y: rect.height/2)
        let radius = min(rect.width, rect.height)/2
        let path = CGMutablePath()

        path.move(to: center)
        path.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        )
        path.closeSubpath()

        context.addPath(path)
        context.setFillColor(UIColor.red.cgColor)
        context.fillPath()
    }
}
