import UIKit

struct Saving {
    let savings: [SavingMonth]
    let savingSum: Int
}

struct SavingMonth {
    let date: String
    let price: Int
    
    init(data: [String: Any]) {
        self.date = data["date"] as? String ?? ""
        self.price = data["price"] as? Int ?? 0
    }
}
