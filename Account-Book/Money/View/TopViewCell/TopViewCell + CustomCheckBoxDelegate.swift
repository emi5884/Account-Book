import UIKit

extension TopViewCell: CustomCheckBoxDelegate {
    
    func checkValue(isChecked: Bool) {
        guard var item = viewModel?.item else { return }
        item.isChecked = isChecked
        delegate?.checkValue(item: item)
    }
}
