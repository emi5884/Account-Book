import UIKit

struct ItemService {
    
    static var monthAndDateWithSlash: String {
        let date = DateFormatter.dateString(date: Date())
        let removeDay = String(date.dropLast(3))
        return removeDay
    }
    
    static func uploadItem(data: [String: Any], completion: @escaping(Item) -> Void) {
        
        let ref = COLLECTION_ITEMS.document()
        let itemID = ref.documentID
        
        var data = data
        data.updateValue(itemID, forKey: "itemID")
        data.updateValue(monthAndDateWithSlash, forKey: "date")
        
        
        let date = DateFormatter.dateString(date: Date())
        let removeDay = date.dropLast(3)
        
        data.updateValue(removeDay, forKey: "date")
        
        ref.setData(data) { error in
            if let error = error {
                print("failed to upload item: \(error.localizedDescription)")
                return
            }
            
            ref.getDocument { document, _ in
                guard let data = document?.data() else { return }
                let item = Item(data: data)
                
                completion(item)
            }
        }
    }
    
    static func fetchItem(completion: @escaping([Item]) -> Void) {
        COLLECTION_ITEMS.order(by: "timeStamp", descending: false).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            var items = documents.map { Item(data: $0.data()) }
            items.removeAll(where: { $0.date != monthAndDateWithSlash && $0.spendingType == "variable" })
            
            completion(items)
        }
    }
    
    static func editItem(item: Item, completion: @escaping([Item]) -> Void) {
        let ref = COLLECTION_ITEMS.document(item.itemID)
        let data: [String: Any] = ["name": item.name, "price": item.price]
        
        ref.updateData(data) { error in
            fetchItem { items in
                completion(items)
            }
        }
    }
    
    static func changeCheckValue(item: Item, shouldAddHistory: Bool, completion: @escaping(Error?) -> Void) {
        
        let ref = COLLECTION_ITEMS.document(item.itemID)
        let data: [String: Any] = ["isChecked": item.isChecked]
        
        ref.updateData(data)  { error in
            if let error = error {
                print("failed to change checke value: \(error.localizedDescription)")
                return
            }
            
            if item.isChecked && shouldAddHistory {
                HistoryService.uploadHistoryItem(item: item, completion: completion)
            }
            
            completion(error)
        }
    }
}
