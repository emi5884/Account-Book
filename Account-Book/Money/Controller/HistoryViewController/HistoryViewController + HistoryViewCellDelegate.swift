import UIKit

extension HistoryViewController: HistoryViewCellDelegate {
    
    func selectItem(cellNumber: Int, shouldRemove: Bool) {
        
        let selectedItemId = historyItems[cellNumber].itemID
 
        if shouldRemove {
            selectedHistoryItems.removeAll(where: { $0.itemID == selectedItemId })
        } else {
            selectedHistoryItems.append(historyItems[cellNumber])
        }
        
        registerButtonUI()
    }
    
    func registerButtonUI() {
        let isSelected = selectedHistoryItems.count > 0
        registerButton.backgroundColor = isSelected ? .customYellow() : .customLightNavyBlue()
        
        let titleColor = isSelected ? UIColor.customNavyBlue() : UIColor.white.withAlphaComponent(0.3)
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.banana(size: 22),
                                                         .foregroundColor: titleColor,
                                                         .kern: 3]
        let attributedTitle = NSAttributedString(string: " 選択", attributes: attributes)
        registerButton.setAttributedTitle(attributedTitle, for: .normal)
    }
}
