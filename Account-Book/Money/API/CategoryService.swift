import UIKit
import Firebase

struct CategoryService {
    
    static var monthAndDateWithSlash: String {
        let date = DateFormatter.dateString(date: Date())
        let removeDay = String(date.dropLast(3))
        return removeDay
    }
    
    static func uploadCategory(categoryInfo: CategoryInfo, completion: @escaping(String) -> Void) {
        ImageUploader.uploadImage(image: categoryInfo.categoryImage) { imageUrl in
            
            let data: [String: Any] = ["imageUrl": imageUrl,
                                       "type": categoryInfo.type,
                                       "date": monthAndDateWithSlash,
                                       "timeStamp": Timestamp()]
            
            COLLECTION_CATEGORIES.addDocument(data: data) { error in
                if let error = error {
                    print("failed to upload category: \(error.localizedDescription)")
                    return
                }
                
                completion(imageUrl)
            }
        }
    }
    
    static func fetchCategories(completion: @escaping([Category]) -> Void) {
        COLLECTION_CATEGORIES.order(by: "timeStamp", descending: false).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            var categories = documents.map { Category(data: $0.data()) }
            categories.removeAll(where: { $0.date != monthAndDateWithSlash })
            
            completion(categories)
        }
    }
}
