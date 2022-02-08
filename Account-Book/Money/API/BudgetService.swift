import UIKit

struct BudgetService {
    
    static let date = DateFormatter.dateString(date: Date())
    static let documentTitle = date.replacingOccurrences(of: "/", with: "")
    
    static func uploadSum(sumInfo: BudgetInfo, completion: @escaping(Error?) -> Void) {
        
        let data: [String: Any] = ["date": date,
                                   "income": sumInfo.income,
                                   "spending": sumInfo.spending,
                                   "saving": sumInfo.saving]
        
        let ref = COLLECTION_BUDGETS.document(documentTitle)
        
        ref.getDocument { snapshot, _ in
            guard let isExist = snapshot?.exists  else { return }
            
            if isExist {
                ref.updateData(data, completion: completion)
            } else {
                ref.setData(data, completion: completion)
            }
        }
    }
    
    static func fetchSum(completion: @escaping(Budget) -> Void) {
        COLLECTION_BUDGETS.document(documentTitle).getDocument { document, _ in
            guard let data = document?.data() else { return }
            let budget = Budget(data: data)
            completion(budget)
        }
    }
}
