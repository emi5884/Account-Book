import UIKit
import SDWebImage

class SpendingMonthViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    public var viewModel: SpendingMonthViewModel? {
        didSet { configureViewModel() }
    }
    
    private let categoryImage = UIButton.createImageView(image: #imageLiteral(resourceName: "1-home"), radius: 25)
    private let priceLabel = UILabel.createBoldFontLabel(text: "", size: 18)
    private let nextPageButton = UIButton.createImageView(image: #imageLiteral(resourceName: "arrow-right"), radius: 0)
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        selectionStyle = .none
        backgroundColor = .customNavyBlue()
        
        addSubview(categoryImage)
        categoryImage.anchor(left: leftAnchor, paddingLeft: 20)
        categoryImage.setDimensions(height: 50, width: 50)
        categoryImage.centerY(inView: self)
        
        addSubview(nextPageButton)
        nextPageButton.anchor(right: rightAnchor, paddingRight: 10)
        nextPageButton.setDimensions(height: 30, width: 30)
        nextPageButton.centerY(inView: self)
        nextPageButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        addSubview(priceLabel)
        priceLabel.anchor(right: nextPageButton.leftAnchor, paddingRight: 20)
        priceLabel.centerY(inView: self)
    }
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        categoryImage.sd_setImage(with: viewModel.categoryImage, for: .normal, completed: nil)
        categoryImage.backgroundColor = .customYellow()
        
        let textAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.banana(size: 18), .kern: 1]
        let numberAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.abraham(size: 18), .kern: 3]
        let attributedText = NSMutableAttributedString(string: "￥ ", attributes: textAttributes)
        attributedText.append(NSAttributedString(string: "\(viewModel.spendingSum)", attributes: numberAttributes))
        priceLabel.attributedText = attributedText
    }
}
