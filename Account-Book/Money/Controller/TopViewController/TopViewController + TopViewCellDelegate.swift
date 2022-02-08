import UIKit

extension TopViewController: TopViewCellDelegate {
    
    func checkValue(item: Item) {
        changeCheckValue(item: item)
        changeLocalCheckedValue(item: item)
    }
    
    func changeLocalCheckedValue(item: Item) {
        var itemNumber = 0
        allItems.forEach {
            if $0.itemID == item.itemID {
                allItems[itemNumber].isChecked = item.isChecked
            }
            itemNumber += 1
        }
    }
}
