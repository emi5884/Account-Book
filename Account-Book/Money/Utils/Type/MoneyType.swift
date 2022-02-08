import UIKit

enum MoneyType {
    case income
    case spending
    case saving
    
    var title: String {
        switch self {
        case .income:
            return "収入"
        case .spending:
            return "支出"
        case .saving:
            return "貯蓄"
        }
    }
}
