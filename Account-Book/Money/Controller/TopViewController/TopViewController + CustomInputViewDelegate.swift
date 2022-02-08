import UIKit
import Firebase

extension TopViewController: CustomInputViewDelegate {
    
    func registerItem(view: CustomInputView) {
        
        let categoryImageUrl = selectedCategoryImageUrl
        guard let name = view.nameTextField.text else { return }
        guard let price = view.priceTextField.text else { return }
        guard let priceInt = Int(price) else { return }
        let isChecked = view.isChecked
        
        let data: [String: Any] = ["spendingType": spendingType.text,
                                   "categoryUrl": categoryImageUrl,
                                   "name": name,
                                   "price": priceInt,
                                   "isChecked": isChecked,
                                   "timeStamp": Timestamp()]
        uploadItem(data: data)
    }
}
