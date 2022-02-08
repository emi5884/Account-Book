import UIKit

protocol CategeoryBarDelegate {
    func showCategoryView()
    func showHistoryView(cell: CategoryBarCell)
    func selectedCategory(imageUrl: String)
}

class CategeoryBar: UIView {
    
    // MARK: - Properties
    
    public var categeoryBarDelegate: CategeoryBarDelegate?
    private let identifier = "identifier"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(CategoryBarCell.self, forCellWithReuseIdentifier: identifier)
        cv.backgroundColor = .customNavyBlue()
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private var didSelectFromSelectedList = false
    private lazy var formarSelectedCell = defaultFormaerSelectedCell()
    
    private var categories: [Category] = []
    
    private lazy var showCategoryListButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "add-line"), for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 27.5
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        button.addTarget(self, action: #selector(didTapCategoryListButton), for: .touchUpInside)
        return button
    }()
    
    private var reloadCount = 0
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(showCategoryListButton)
        showCategoryListButton.anchor(top: topAnchor,
                                      left: leftAnchor,
                                      paddingTop: 10,
                                      paddingLeft: 15)
        showCategoryListButton.setDimensions(height: 55, width: 55)
        
        addSubview(collectionView)
        collectionView.anchor(top: topAnchor,
                              left: showCategoryListButton.rightAnchor,
                              bottom: bottomAnchor,
                              right: rightAnchor,
                              paddingLeft: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc func didTapCategoryListButton() {
        categeoryBarDelegate?.showCategoryView()
    }
    
    // MARK: - Helper
    
    func selectNewCategory(categories: [Category]) {
        didSelectFromSelectedList = true
        
        self.categories = categories
        collectionView.reloadData()
    }
    
    func changeSpendingType(categories: [Category]) {
        didSelectFromSelectedList = false
        
        self.categories = categories
        collectionView.reloadData()
    }
    
    func defaultFormaerSelectedCell() -> CategoryBarCell {
        guard let cell = collectionView.cellForItem(at:IndexPath(item: 1, section: 0)) as? CategoryBarCell else { return CategoryBarCell() }
        return cell
    }
}

// MARK: - UICollectionViewDataSource

extension CategeoryBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CategoryBarCell
        cell.delegate = self
        
        if didSelectFromSelectedList {
            let selectedCell = indexPath.row == categories.count - 1
            cell.viewModel = CategoryBarViewModel(category: categories[indexPath.row],
                                                  isSelected: selectedCell,
                                                  cellNumber: indexPath.row)
            
        } else {
            let firstCell = indexPath.row == 0
            cell.viewModel = CategoryBarViewModel(category: categories[indexPath.row],
                                                  isSelected: firstCell,
                                                  cellNumber: indexPath.row)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension CategeoryBar: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        for item in 0 ..< categories.count {
            let indexPath = IndexPath(item: item, section: 0)
            guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryBarCell else { return }
            cell.selectCategory(isSelected: false)
        }
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryBarCell else { return }
        cell.selectCategory(isSelected: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CategeoryBar: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = frame.height - 20
        return CGSize(width: 55, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}

