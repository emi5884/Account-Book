import UIKit

struct ItemViewModel {
    let item: Item
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
    
    init(item: Item, cellNumber: Int) {
        self.item = item
        self.cellNumber = cellNumber
    }
}
