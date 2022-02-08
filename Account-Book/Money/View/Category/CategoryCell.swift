import UIKit

class CategoryCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    public lazy var imageView = UIButton.createImageView(image: #imageLiteral(resourceName: "close"), radius: frame.width / 2)
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    
    func configureImageView() {
        addSubview(imageView)
        imageView.anchor(top: topAnchor)
        imageView.setDimensions(height: frame.width, width: frame.width)
    }
}
