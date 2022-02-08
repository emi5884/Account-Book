import UIKit

struct IncomeService {
    
    static func registerIncome(incomeInfo: IncomeInfo, completion: @escaping(Error?) -> Void) {
        
        let ref = COLLECTION_INCOMES.document()
        let incomeID = ref.documentID
        
        let data: [String: Any] = ["name": incomeInfo.name,
                                   "price": incomeInfo.price,
                                   "incomeID": incomeID]
        
        ref.setData(data, completion: completion)
    }
    
    static func fetchIncome(completion: @escaping([Income]) -> Void) {
        
        COLLECTION_INCOMES.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            let incomes = documents.map { Income(data: $0.data()) }
            completion(incomes)
        }
    }
    
    static func editIncome(incomeInfo: IncomeInfo, incomeID: String, completion: @escaping(Error?) -> Void) {
        let ref = COLLECTION_INCOMES.document(incomeID)
        
        ref.getDocument { document, _ in
            guard let _ = document?.exists else { return }
            
            let data: [String: Any] = ["name": incomeInfo.name,
                                       "price": incomeInfo.price,
                                       "incomeID": incomeID]
            
            ref.updateData(data, completion: completion)
        }
    }
}
