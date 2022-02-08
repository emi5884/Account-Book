import UIKit

struct Dimension {
    
    static let keyboardHeight: CGFloat = 336
    
    static var safeAreaTopHeight: CGFloat = 47
    static var safeAreaBottomHeight: CGFloat = 34
    
    static var safeAreaTop: CGFloat {
        get {
            return safeAreaTopHeight
        }
        
        set(height) {
            safeAreaTopHeight = height
        }
    }
    
    static var safeAreaBottom: CGFloat {
        get {
            return safeAreaBottomHeight
        }
        
        set(height) {
            safeAreaBottomHeight = height
        }
    }
}
