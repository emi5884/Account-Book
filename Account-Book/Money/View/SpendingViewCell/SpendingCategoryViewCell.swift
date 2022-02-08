import UIKit

class SpendingCategoryViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    public var viewModel: ItemViewModel? {
        didSet { configureViewModel() }
    }
    
    private let itemLabel = UILabel.createBoldFontLabel(text: "", size: 18)
    private let priceLabel = UILabel.createBoldFontLabel(text: "", size: 18)
    
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
        
        addSubview(itemLabel)
        itemLabel.anchor(left: leftAnchor, paddingLeft: 20)
        itemLabel.centerY(inView: self)
        
        addSubview(priceLabel)
        priceLabel.anchor(right: rightAnchor, paddingRight: 20)
        priceLabel.centerY(inView: self)
    }
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        let nameAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.banana(size: 18), .kern: 1, .foregroundColor: UIColor.white]
        let itemLabelAttributedText = NSAttributedString(string: "\(viewModel.name)", attributes: nameAttributes)
        itemLabel.attributedText = itemLabelAttributedText
        
        let priceAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.abraham(size: 18), .kern: 3, .foregroundColor: UIColor.white]
        let priceLabelAttributedText = NSMutableAttributedString(string: "￥ ", attributes: nameAttributes)
        priceLabelAttributedText.append(NSAttributedString(string: "\(viewModel.price)", attributes: priceAttributes))
        priceLabel.attributedText = priceLabelAttributedText
    }
}
