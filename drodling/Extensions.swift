import CoreGraphics

extension Int {
    var degreesToRadians: CGFloat {
        return  CGFloat(self) * CGFloat.pi / 180
    }
}
