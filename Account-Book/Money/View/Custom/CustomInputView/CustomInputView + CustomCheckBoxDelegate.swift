import UIKit

extension CustomInputView: CustomCheckBoxDelegate {
    func checkValue(isChecked: Bool) {
        self.isChecked = isChecked
    }
}
