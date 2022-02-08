import UIKit

protocol CustomCheckBoxDelegate {
    func checkValue(isChecked: Bool)
}

class CustomCheckBox: UIView {
    
    // MARK: - Properties
    
    public var delegate: CustomCheckBoxDelegate?
    
    private lazy var checkBoxView: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1.5
        
        button.addTarget(self, action: #selector(didTapSquare), for: .touchUpInside)
        let borderColor = isInput ? UIColor.customLightNavyBlue().cgColor : UIColor.white.cgColor
        button.layer.borderColor = borderColor
        
        return button
    }()
    
    private lazy var checkLabel: UILabel = {
        let label = UILabel()
        label.text = "✓"
        label.textAlignment = .center
        label.isHidden = true
        
        let borderColor = isInput ? UIColor.customLightNavyBlue() : UIColor.white
        label.textColor = borderColor
        
        return label
    }()
    
    private var isChecked = false
    private var isInput = false
    
    private var didsetDefaultCheckValue = false
    
    // MARK: - LifeCycle
    
    init(frame: CGRect, isInput: Bool) {
        self.isInput = isInput
        
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc func didTapSquare() {
        checkLabel.isHidden.toggle()
        isChecked.toggle()
        delegate?.checkValue(isChecked: isChecked)
    }
    
    // MARK: - Helper
    
    func configureUI() {
        addSubview(checkBoxView)
        checkBoxView.fillSuperview()
        
        addSubview(checkLabel)
        checkLabel.fillSuperview()
    }
    
    func topViewCellCheckValue(isChecked: Bool) {
        checkLabel.isHidden = isChecked ? false : true
        self.isChecked = isChecked
    }
    
    func defaulteUI() {
        checkLabel.isHidden = true
        self.isChecked = false
    }
}
