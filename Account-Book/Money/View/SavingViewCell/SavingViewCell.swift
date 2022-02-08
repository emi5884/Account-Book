import UIKit

class SavingCell: UITableViewCell {
    
    // MARK: - Properties
    
    public var viewModel: SavingViewModel? {
        didSet { configureViewModel()  }
    }
    
    private let dateLabel = UITextField.createLabelTextField(text: "")
    private let priceLabel = UITextField.createLabelTextField(text: "")
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    
    func configureUI() {
        selectionStyle = .none
        backgroundColor = .customNavyBlue()
        
        addSubview(dateLabel)
        dateLabel.anchor(left: leftAnchor,
                         paddingLeft: 20)
        dateLabel.centerY(inView: self)
        
        addSubview(priceLabel)
        priceLabel.anchor(right: rightAnchor, paddingRight: 20)
        priceLabel.setDimensions(height: frame.height, width: 150)
        priceLabel.centerY(inView: self)
    }
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        let textAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.banana(size: 18), .kern: 3]
        let numberAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.abraham(size: 18), .kern: 3]
        
        dateLabel.attributedText = NSAttributedString(string: viewModel.date, attributes: numberAttributes)
    
        let priceAttributedText = NSMutableAttributedString(string: "￥  ", attributes: textAttributes)
        priceAttributedText.append(NSAttributedString(string: "\(viewModel.price)", attributes: numberAttributes))
        priceLabel.attributedText = priceAttributedText
    }
}
