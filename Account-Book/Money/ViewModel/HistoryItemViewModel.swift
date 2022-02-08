import Foundation

struct HistoryItemViewModel {
    let item: HistoryItem
    let cellNumber: Int
    
    var isChecked: Bool {
        return item.isChecked
    }
    
    var name: String {
        return item.name
    }
    
    var price: Int {
        return item.price
    }
    
    init(item: HistoryItem, cellNumber: Int) {
        self.item = item
        self.cellNumber = cellNumber
    }
}
