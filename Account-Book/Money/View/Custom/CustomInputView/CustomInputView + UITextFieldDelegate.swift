import UIKit

extension CustomInputView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        closeButton.isHidden = false
        
        switch textField {
        case nameTextField:
            
            let isPriceTextEmpty = priceTextField.text?.count == 0
            pricePlaceholederLabel.isHidden = isPriceTextEmpty ? false : true
            namePlaceholederLabel.isHidden = true
            
            UIView.animate(withDuration: 0.25) {
                self.nameTextFieldSize?.isActive = false
                self.priceTextFieldSize?.isActive = true
                self.layoutIfNeeded()
            }
            
        case priceTextField:
            
            let isnameTextEmpty = nameTextField.text?.count == 0
            namePlaceholederLabel.isHidden = isnameTextEmpty ? false : true
            pricePlaceholederLabel.isHidden = true
            
            UIView.animate(withDuration: 0.25) {
                self.nameTextFieldSize?.isActive = true
                self.priceTextFieldSize?.isActive = false
                self.layoutIfNeeded()
            }
            
        default:
            break
        }
    }
}
