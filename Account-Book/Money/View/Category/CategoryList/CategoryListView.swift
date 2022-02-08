import UIKit

protocol CategoryListViewDelegate {
    func selectCategory(image: UIImage, cell: CategoryListCell)
}

class CategoryListView: UIView {
    
    // MARK: - Properties
    
    public var delegate: CategoryListViewDelegate?
    
    private let identifier = "identifier"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(CategoryListCell.self, forCellWithReuseIdentifier: identifier)
        cv.backgroundColor = .customWhite()
        cv.contentInset = UIEdgeInsets(top: 20, left:20, bottom: 10, right: 20)
        cv.showsHorizontalScrollIndicator = false
        cv.layer.cornerRadius = 50
        return cv
    }()
    
    private let categoryImages = CategoryHelper.images()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
}

// MARK: - UICollectionViewDataSource

extension CategoryListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CategoryListCell
        cell.categoryImage = categoryImages[indexPath.row]
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension CategoryListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryListCell else { return }
        delegate?.selectCategory(image: categoryImages[indexPath.row], cell: cell)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CategoryListView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (frame.width - 40) / 7
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
