import UIKit

struct SpendingMonthViewModel {
    let spending: SpendingMonth
    
    var categoryImage: URL? {
        return URL(string: spending.categoryImageUrl)
    }
    
    var spendingSum: Int {
        return spending.savingSum
    }
    
    var items: [Item] {
        return spending.items
    }
    
    init(spending: SpendingMonth) {
        self.spending = spending
    }
}
