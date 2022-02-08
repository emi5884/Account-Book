import UIKit

struct Budget {
    let month: String
    let income: Int
    let spending: Int
    let saving: Int
    
    init(data: [String: Any]) {
        self.month = data["date"] as? String ?? ""
        self.income = data["income"] as? Int ?? 0
        self.spending = data["spending"] as? Int ?? 0
        self.saving = data["saving"] as? Int ?? 0
    }
}
