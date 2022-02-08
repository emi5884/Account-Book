import UIKit

class CategoryBarViewModel {
    let category: Category
    let isSelected: Bool
    let cellNumber: Int
    
    var imageUrl: URL? {
        return URL(string: category.imageUrl)
    }
    
    init(category: Category, isSelected: Bool, cellNumber: Int) {
        self.category = category
        self.isSelected = isSelected
        self.cellNumber = cellNumber
    }
}
