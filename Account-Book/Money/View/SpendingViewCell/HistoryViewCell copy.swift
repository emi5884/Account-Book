import UIKit

class HistoryViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let squareView = CustomCheckBox()
    private let nameTextLabel = UITextField.createLabelTextField(text: "にんじん")
    private let priceTextLabel = UITextField.createLabelTextField(text: "￥100")
    
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
        
        contentView.addSubview(squareView)
        squareView.anchor(left: leftAnchor,
                          paddingLeft: 10)
        squareView.setDimensions(height: 25, width: 25)
        squareView.centerY(inView: self)
        
        addSubview(nameTextLabel)
        nameTextLabel.anchor(left: squareView.rightAnchor,
                             paddingLeft: 10)
        nameTextLabel.centerY(inView: self)
        
        addSubview(priceTextLabel)
        priceTextLabel.anchor(right: rightAnchor, paddingRight: 10)
        priceTextLabel.centerY(inView: self)
    }
}
