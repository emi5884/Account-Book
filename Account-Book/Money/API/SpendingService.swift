import UIKit
import Firebase

struct SpendingService {
    
    static var monthAndDateWithoutSlash: String {
        let date = DateFormatter.dateString(date: Date())
        let removeDay = date.dropLast(3)
        let documentTitle = removeDay.replacingOccurrences(of: "/", with: "")
        return documentTitle
    }
    
    static var monthAndDateWithSlash: String {
        let date = DateFormatter.dateString(date: Date())
        let removeDay = String(date.dropLast(3))
        return removeDay
    }
    
    static func uploadSpending(spendingInfo: SpendingInfo, completion: @escaping(Error?) -> Void) {
        
        let data: [String: Any] = ["savingCost": spendingInfo.cost,
                                   "categories": spendingInfo.categories,
                                   "date": monthAndDateWithSlash]
        
        COLLECTION_SPENDING.document(monthAndDateWithoutSlash).setData(data, completion: completion)
    }
    
    static func fetchSpending(completion: @escaping([Spending]) -> Void) {
        COLLECTION_SPENDING.order(by: "date", descending: true).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            let savings = documents.map { Spending(data: $0.data()) }
            completion(savings)
        }
    }
    
    static func fetchCategories(date: String, completion: @escaping([SpendingMonth]) -> Void) {
        
        COLLECTION_CATEGORIES.whereField("date", isEqualTo: date).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let categories = documents.map { Category(data: $0.data()) }
            
            var spendingMonths: [SpendingMonth] = []
            var shouldCompleteCount = 0
            
            categories.forEach { category in
                COLLECTION_ITEMS.whereField("categoryUrl", isEqualTo: category.imageUrl).getDocuments { snapshot, _ in
                    guard let documents = snapshot?.documents else { return }
                    
                    let items = documents.map { Item(data: $0.data()) }
                    var isCheckedItems: [Item] = []
                    
                    items.forEach { item in
                        if item.isChecked == true {
                            isCheckedItems.append(item)
                        }
                    }
                    
                    let prices = isCheckedItems.map { $0.price }
                    let priceSum = prices.reduce(0) { $0 + $1 }
                    
                    let spendingMonth = SpendingMonth(savingSum: priceSum, categoryImageUrl: category.imageUrl, items: isCheckedItems)
                    spendingMonths.append(spendingMonth)
                    shouldCompleteCount += 1
                    
                    if shouldCompleteCount == categories.count {
                        completion(spendingMonths)
                    }
                }
            }
        }
    }
}
