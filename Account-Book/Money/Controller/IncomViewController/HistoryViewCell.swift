import UIKit

protocol HistoryViewCellDelegate {
    func selectItem(cellNumber: Int, shouldRemove: Bool)
}

class HistoryViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    public var delegate: HistoryViewCellDelegate?
    
    public var viewModel: HistoryItemViewModel? {
        didSet { configureViewModel() }
    }
    
    private let nameLabel = UITextField.createLabelTextField(text: "")
    private let priceLabel = UITextField.createLabelTextField(text: "")
    private lazy var selectButton = UIButton.createTextButton(text: " 選択",
                                                              target: self,
                                                              selector: #selector(didTapSelectButton))
    private var alreadySelected = false
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc func didTapSelectButton() {
        guard let cellNumber = viewModel?.cellNumber else { return }
        delegate?.selectItem(cellNumber: cellNumber,
                             shouldRemove: alreadySelected)
        
        if alreadySelected {
            deSelectedUI()
        } else {
            selectedUI()
        }
        
        alreadySelected.toggle()
    }
    
    // MARK: - Helper
    
    func configureUI() {
        selectionStyle = .none
        backgroundColor = .customNavyBlue()
        
        addSubview(nameLabel)
        nameLabel.anchor(left: leftAnchor,
                         paddingLeft: 20)
        nameLabel.centerY(inView: self)
        
        contentView.addSubview(selectButton)
        selectButton.anchor(right: rightAnchor,
                            paddingRight: 10,
                            width: 100)
        selectButton.centerY(inView: self)
        
        addSubview(priceLabel)
        priceLabel.anchor(right: selectButton.leftAnchor,
                          paddingRight: 20,
                          width: 100)
        priceLabel.centerY(inView: self)
    }
    
    func configureViewModel() {
        
        guard let viewModel = viewModel else { return }
        
        let nameAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.banana(size: 18), .kern: 1]
        nameLabel.attributedText = NSAttributedString(string: viewModel.name, attributes: nameAttributes)
        
        let priceAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.abraham(size: 18), .kern: 3]
        let priceAttributedText = NSMutableAttributedString(string: "￥  ", attributes: nameAttributes)
        priceAttributedText.append(NSAttributedString(string: "\(viewModel.price)", attributes: priceAttributes))
        priceLabel.attributedText = priceAttributedText
    }
    
    func selectedUI() {
        selectButton.backgroundColor = .white
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.banana(size: 17), .kern: 3, .foregroundColor: UIColor.customNavyBlue()]
        let attributedTitle = NSAttributedString(string: " 選択", attributes: attributes)
        selectButton.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    func deSelectedUI() {
        selectButton.backgroundColor = .customLightNavyBlue()
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.banana(size: 17), .kern: 3, .foregroundColor: UIColor.white]
        let attributedTitle = NSAttributedString(string: " 選択", attributes: attributes)
        selectButton.setAttributedTitle(attributedTitle, for: .normal)
    }
}
