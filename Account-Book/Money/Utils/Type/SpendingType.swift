import UIKit

enum SpendingType {
    case fixed
    case variable
    
    var text: String {
        
        switch self {
        case .fixed:
            return "fixed"
        case .variable:
            return "variable"
        }
    }
}
