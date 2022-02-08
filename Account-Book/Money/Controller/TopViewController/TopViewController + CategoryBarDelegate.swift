import UIKit
import Hero
import Firebase

extension TopViewController: CategeoryBarDelegate {
    
    func selectedCategory(imageUrl: String) {
        selectedCategoryImageUrl = imageUrl
        swapListCategory()
        swapHistoryCategory()
    }
    
    func showHistoryView(cell:  CategoryBarCell) {
        cell.imageView.hero.id = "showHistoryView"
        guard let image = cell.imageView.image(for: .normal) else { return }
        guard let imageUrl = cell.viewModel?.imageUrl?.absoluteString else { return }
        
        var categoryItems: [HistoryItem] = []
        selectedHistoryItems.forEach { item in
            if item.categoryUrl ==  imageUrl {
                categoryItems.append(item)
            }
        }
        
        let vc = HistoryViewController(image: image, historyItems: selectedHistoryItems)
        vc.modalPresentationStyle = .fullScreen
        vc.mainImageView.hero.id = "showHistoryView"
        vc.isHeroEnabled = true
        vc.heroItem = cell.imageView
        
        vc.completion = { selectedItems in
            selectedItems.forEach { item in
                
                let data: [String: Any] = ["spendingType": item.spendingType,
                                           "categoryUrl": item.categoryUrl,
                                           "name": item.name,
                                           "price": item.price,
                                           "isChecked": false,
                                           "timeStamp": Timestamp()]
                
                self.uploadItem(data: data)
            }
        }
        
        present(vc, animated: true, completion: nil)
    }
    
    func showCategoryView() {
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.categoryListView.frame.origin.y -= self.categoryViewHeight
            self.backgroundView.alpha = 1
        }
    }
}
