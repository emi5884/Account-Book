import UIKit

struct SpendingViewModel {
    let spending: Spending
    
    var date: String {
        return spending.date
    }
    
    var savingPrice: Int {
        return spending.savingCost
    }
    
    init(saving: Spending) {
        self.spending = saving
    }
}
