import UIKit
import Firebase

struct Category {
    let imageUrl: String
    let type: String
    let date: String
    let timeStamp: Timestamp
    
    init(data: [String: Any]) {
        self.imageUrl = data["imageUrl"] as? String ?? ""
        self.type = data["type"] as? String ?? ""
        self.date  = data["date"] as? String ?? ""
        self.timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
    }
}
