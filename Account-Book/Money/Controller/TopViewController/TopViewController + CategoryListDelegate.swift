import UIKit

extension TopViewController: CategoryListViewDelegate {
    func selectCategory(image: UIImage, cell: CategoryListCell) {
        uploadNewCategory(image: image, cell: cell)
    }
}
