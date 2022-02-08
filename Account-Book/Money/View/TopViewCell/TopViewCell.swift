import UIKit

protocol TopViewCellDelegate {
    func checkValue(item: Item)
}

class TopViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    public var delegate: TopViewCellDelegate?
    
    public var viewModel: ItemViewModel? {
        didSet { configureViewModel() }
    }
    
    private let squareView = CustomCheckBox(frame: .zero, isInput: false)
    private let nameLabel = UITextField.createLabelTextField(text: "")
    private let priceLabel = UITextField.createLabelTextField(text: "")
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    
    func configureUI() {
        selectionStyle = .none
        backgroundColor = .customNavyBlue()
        
        contentView.addSubview(squareView)
        squareView.anchor(left: leftAnchor,
                          paddingLeft: 20)
        squareView.setDimensions(height: 25, width: 25)
        squareView.centerY(inView: self)
        
        addSubview(nameLabel)
        nameLabel.anchor(left: squareView.rightAnchor,
                             paddingLeft: 20)
        nameLabel.centerY(inView: self)
        
        addSubview(priceLabel)
        priceLabel.anchor(right: rightAnchor, paddingRight: 20)
        priceLabel.setDimensions(height: frame.height, width: 100)
        priceLabel.centerY(inView: self)
    }
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        let textAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.banana(size: 18), .kern: 1]
        nameLabel.attributedText = NSAttributedString(string: viewModel.name, attributes: textAttributes)
        
        let numberAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.abraham(size: 18), .kern: 3]
        let priceAttributedTextg = NSMutableAttributedString(string: "￥  ", attributes: textAttributes)
        priceAttributedTextg.append(NSAttributedString(string: "\(viewModel.price)", attributes: numberAttributes))
        priceLabel.attributedText = priceAttributedTextg
        
        squareView.topViewCellCheckValue(isChecked: viewModel.isChecked)
    }
    
    func setDelegate() {
        squareView.delegate = self
    }
}
