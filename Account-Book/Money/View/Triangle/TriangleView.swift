import UIKit

class TriangleView: UIView {
    
    // MARK: - Properties
    
    private lazy var halfFrameWidth: CGFloat = frame.width / 2
    private lazy var frameWidth: CGFloat = frame.width
    private lazy var frameHeight: CGFloat = frame.height
    private lazy var circleRadius: CGFloat = 5
    
    // MARK: - LifeCycle
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: halfFrameWidth + circleRadius, y: circleRadius))
        path.addLine(to: CGPoint(x: frameWidth, y: frameHeight))
        path.addLine(to: CGPoint(x: 0, y: frameHeight))
        path.addLine(to: CGPoint(x: halfFrameWidth - circleRadius, y: circleRadius))
        path.addLine(to: CGPoint(x: halfFrameWidth + circleRadius, y: circleRadius))
        path.close()
        
        UIColor.customNavyBlue().setFill()
        path.fill()
        
        let circle = UIBezierPath(arcCenter: CGPoint(x: halfFrameWidth, y: circleRadius),
                                  radius: circleRadius,
                                  startAngle: 0,
                                  endAngle: .pi * 2,
                                  clockwise: true)
        circle.fill()
    }
}
