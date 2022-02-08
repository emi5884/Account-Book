import UIKit

struct Income {
    let name: String
    let price: Int
    let incomeID: String
    
    init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.price = data["price"] as? Int ?? 0
        self.incomeID = data["incomeID"] as? String ?? ""
    }
}
