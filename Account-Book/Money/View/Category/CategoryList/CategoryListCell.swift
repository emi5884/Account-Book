import UIKit

class CategoryListCell: CategoryCell {
    
    // MARK: - Properties
    
    public var categoryImage: UIImage = UIImage() {
        didSet { setCategoryListImage(image: categoryImage) }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.backgroundColor = isSelected ? .customYellow() : .clear
        }
    }
    
    // MARK: - Helpers
    
    func setCategoryListImage(image: UIImage) {
        imageView.setImage(image, for: .normal)
        imageView.backgroundColor = .clear
    }
}
