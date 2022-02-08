import UIKit

extension UIFont {
    
    static func digitalFont(size: CGFloat) -> UIFont {
        return UIFont(name: "Let's go Digital Regular", size: size ) ?? .systemFont(ofSize: size)
    }
    
    static func abraham(size: CGFloat) -> UIFont {
        return UIFont(name: "Abraham", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func banana(size: CGFloat) -> UIFont {
        return UIFont(name: "bananaslipplus", size: size) ?? .systemFont(ofSize: size)
    }
}
