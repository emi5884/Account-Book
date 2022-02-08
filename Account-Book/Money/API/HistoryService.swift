import UIKit
import Firebase

struct HistoryService {
    
    static func uploadHistoryItem(item: Item, completion: @escaping(Error?) -> Void) {
        
        let ref = COLLECTION_HISTORIES.document()
        let itemID = ref.documentID
        
        let data: [String: Any] = ["spendingType": item.spendingType,
                                   "categoryUrl": item.categoryUrl,
                                   "name": item.name,
                                   "price": item.price,
                                   "isChecked": false,
                                   "itemID": itemID,
                                   "count": 0,
                                   "timeStamp": Timestamp()]
        
        ref.setData(data, completion: completion)
    }
    
    static func fetchHistoryItem(completion: @escaping([HistoryItem]) -> Void) {
        COLLECTION_HISTORIES
            .order(by: "count", descending: true)
            .getDocuments { snapshot, _ in
                
            guard let documents = snapshot?.documents else { return }
            let item = documents.map { HistoryItem(data: $0.data()) }
            completion(item)
        }
    }
    
    static func incrementCount(selectItems: [HistoryItem], completion: @escaping (Error?) -> Void) {
        
        selectItems.forEach { item in
            
            let ref = COLLECTION_HISTORIES.document(item.itemID)
            
            ref.getDocument { document, _ in
                guard var data = document?.data() else { return }
                guard let count = data["count"] as? Int else { return }
                data.updateValue(count + 1, forKey: "count")
                
                ref.setData(data, completion: completion)
            }
        }
    }
}
