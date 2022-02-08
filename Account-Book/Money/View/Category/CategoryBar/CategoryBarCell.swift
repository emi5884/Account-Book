import UIKit
import SDWebImage

protocol CategoryBarCellDelegate {
    func showHistoryView(cell: CategoryBarCell)
    func selectedCategoryUrl(url: String)
}

class CategoryBarCell: CategoryCell {
    
    // MARK: - Properties
    
    public var delegate: CategoryBarCellDelegate?
    
    public var viewModel: CategoryBarViewModel? {
        didSet { configureViewModel() }
    }
    
    public lazy var historyButton = UIButton.createImageButton(image: #imageLiteral(resourceName: "history"), target: self, selector: #selector(didTapHistoryButton))
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHistoryButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc func didTapHistoryButton() {
        delegate?.showHistoryView(cell: self)
    }
    
    // MARK: - Helper
    
    func configureHistoryButton() {
        
        contentView.addSubview(historyButton)
        historyButton.isHidden = true
        historyButton.anchor(bottom: bottomAnchor)
        historyButton.setDimensions(height: 40, width: frame.width)
        
        selectCategory(isSelected: false)
    }
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        imageView.sd_setImage(with: viewModel.imageUrl, for: .normal, completed: nil)
        
        Timer.scheduledTimer(withTimeInterval: 0, repeats: false) { _ in
            let isSelected = viewModel.isSelected
            self.selectCategory(isSelected: isSelected)
        }
    }
    
    func selectCategory(isSelected: Bool) {
        let image = imageView.image(for: .normal)?.withRenderingMode(.alwaysTemplate)
        imageView.setImage(image, for: .normal)
        imageView.tintColor = isSelected ? .customNavyBlue() : .white
        imageView.backgroundColor = isSelected ? .customYellow() : .customLightNavyBlue()
        historyButton.isHidden = isSelected ? false : true
        
        if isSelected {
            guard let url = viewModel?.imageUrl?.absoluteString else { return }
            delegate?.selectedCategoryUrl(url: url)
        }
    }
}
