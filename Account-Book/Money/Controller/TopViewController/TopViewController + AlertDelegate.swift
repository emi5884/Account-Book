import UIKit

extension TopViewController: CustomAlertDelegate {
    func beginEditing() {
        UIView.animate(withDuration: 0.25) {
            self.customAlert.frame.origin.y -= 80
        }
    }

    func didTapOkButton(alert: CustomAlert) {
        guard let itemInfo = alert.itemInfo() else { return }
        
        selectedItems[selectedCellNumber].name = itemInfo.name
        selectedItems[selectedCellNumber].price = itemInfo.price
        
        editItem(item: selectedItems[selectedCellNumber])
    }
    
    func didTapCancelButton() {
        dismissAlert()
    }
}
