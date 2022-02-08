import UIKit
import Firebase

struct Spending {
    let savingCost: Int
    let categories: [String]
    let date: String
    
    init(data: [String: Any]) {
        self.savingCost = data["savingCost"] as? Int ?? 0
        self.categories = data["categories"] as? [String] ?? [""]
        self.date = data["date"] as? String ?? ""
    }
}
