import UIKit

extension UITextField {
    
    static func createTextField(placeholder: String) -> UITextField {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.layer.cornerRadius = 5
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.textAlignment = .left
        textField.backgroundColor = .customNavyBlue().withAlphaComponent(0.1)
        textField.textColor = .customNavyBlue()
        return textField
    }
    
    static func createLabelTextField(text: String) -> UITextField {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        
        let textField = UITextField()
        textField.text = text
        textField.textColor = .white
        textField.isUserInteractionEnabled = false
        textField.leftView = leftView
        textField.leftViewMode = .never
        textField.textAlignment = .right
        return textField
    }
}
