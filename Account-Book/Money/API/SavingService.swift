import UIKit

struct SavingService {
    
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
    
    static func uploadSaving(value: Int, completion: @escaping(Error?) -> Void) {
        let data: [String: Any] = ["date": monthAndDateWithSlash, "price": value]
        COLLECTION_SAVINGS.document(monthAndDateWithoutSlash).setData(data, completion: completion)
    }
    
    static func fetchSaving(completion: @escaping(Saving) -> Void) {
        COLLECTION_SAVINGS.order(by: "date", descending: true).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            let savingMonth = documents.map { SavingMonth(data: $0.data()) }
            let savingPrices = savingMonth.map { $0.price }
            let savingSum = savingPrices.reduce(0) { $0 + $1 }
            let saving = Saving(savings: savingMonth, savingSum: savingSum)
            
            completion(saving)
        }
    }
}
