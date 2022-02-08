import UIKit

// MARK: - CategoryViewCellDelegate

extension CategeoryBar: CategoryBarCellDelegate {
    func selectedCategoryUrl(url: String) {
        categeoryBarDelegate?.selectedCategory(imageUrl: url)
    }
    
    func showHistoryView(cell: CategoryBarCell) {
        categeoryBarDelegate?.showHistoryView(cell: cell)
    }
}
