import UIKit

protocol CustomInputViewDelegate {
    func registerItem(view: CustomInputView)
}

class CustomInputView: UIView {
    
    // MARK: - Properties
    
    public var delegate: CustomInputViewDelegate?
    
    private let squareView = CustomCheckBox(frame: .zero, isInput: true)
    public var isChecked = false
    
    public let nameTextField = UITextField.createTextField(placeholder: "")
    public let priceTextField = UITextField.createTextField(placeholder: "")
    public lazy var namePlaceholederLabel = createPlaceHolderLabel(text: " タイトル")
    public lazy var pricePlaceholederLabel = createPlaceHolderLabel(text: "￥")
    private let registerButton = UIButton.createImageButton(image: #imageLiteral(resourceName: "add"), target: self, selector: #selector(didTapRegisterButton))
    public let closeButton = UIButton.createImageButton(image: #imageLiteral(resourceName: "close"), target: self, selector: #selector(didTapCloseButton))
    
    public var nameTextFieldSize: NSLayoutConstraint?
    public var priceTextFieldSize: NSLayoutConstraint?
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc func didTapRegisterButton() {
        delegate?.registerItem(view: self)
        isChecked = false
        setDefaultUI(sender: registerButton)
    }
    
    @objc func didTapCloseButton() {
        setDefaultUI(sender: closeButton)
        closeButton.isHidden = true
        endEditing(true)
    }
    
    // MARK: - Helpers
    func configureUI() {
        
        let buttonSize: CGFloat = 50
        let space: CGFloat = 10
        let squareSize: CGFloat = 25
        let longTextField: CGFloat = frame.size.width - (squareSize + (buttonSize * 2) + (space * 5))
        
        backgroundColor = .clear
        
        addSubview(closeButton)
        closeButton.anchor(top: topAnchor,
                           right: rightAnchor,
                           paddingRight: space)
        closeButton.setDimensions(height: buttonSize, width: buttonSize)

        addSubview(nameTextField)
        nameTextField.anchor(top: closeButton.bottomAnchor,
                              left: leftAnchor,
                              bottom: safeAreaLayoutGuide.bottomAnchor,
                              paddingTop: space,
                              paddingLeft: squareSize + space * 2,
                              paddingBottom: space,
                              width: longTextField)
        
        nameTextField.addSubview(namePlaceholederLabel)
        namePlaceholederLabel.setDimensions(height: buttonSize, width: buttonSize)
        namePlaceholederLabel.centerY(inView: nameTextField)

        addSubview(squareView)
        squareView.anchor(left: leftAnchor,
                          right: nameTextField.leftAnchor,
                          paddingLeft: space,
                          paddingRight: space)
        squareView.setDimensions(height: squareSize, width: squareSize)
        squareView.centerY(inView: nameTextField)

        addSubview(registerButton)
        registerButton.anchor(top: closeButton.bottomAnchor,
                              bottom: safeAreaLayoutGuide.bottomAnchor,
                              right: rightAnchor,
                              paddingTop: space,
                              paddingBottom: space,
                              paddingRight: space)
        registerButton.setDimensions(height: buttonSize, width: buttonSize)
        
        addSubview(priceTextField)
        priceTextField.anchor(top: closeButton.bottomAnchor,
                              left: nameTextField.rightAnchor,
                              bottom: safeAreaLayoutGuide.bottomAnchor,
                              right: registerButton.leftAnchor,
                              paddingTop: space,
                              paddingLeft: space,
                              paddingBottom: space,
                              paddingRight: space)
        
        priceTextField.addSubview(pricePlaceholederLabel)
        pricePlaceholederLabel.setDimensions(height: buttonSize, width: buttonSize)
        pricePlaceholederLabel.centerY(inView: priceTextField)
        
        nameTextFieldSize = nameTextField.widthAnchor.constraint(equalToConstant: buttonSize)
        priceTextFieldSize = priceTextField.widthAnchor.constraint(equalToConstant: buttonSize)
        priceTextFieldSize?.isActive = true
    }
    
    func setDelegate() {
        nameTextField.delegate = self
        priceTextField.delegate = self
        squareView.delegate = self
    }
    
    func createPlaceHolderLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .customLightNavyBlue().withAlphaComponent(0.4)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.banana(size: 13), .kern: 1]
        label.attributedText = NSAttributedString(string:text, attributes: attributes)
        
        return label
    }
    
    func setDefaultUI(sender: UIButton) {
        squareView.defaulteUI()
        
        nameTextField.becomeFirstResponder()
        nameTextField.text = ""
        priceTextField.text = ""
        pricePlaceholederLabel.isHidden = false
        
        nameTextFieldSize?.isActive = false
        priceTextFieldSize?.isActive = true
        
        switch sender {
        case closeButton:
            namePlaceholederLabel.isHidden = false
            
        case registerButton:
            namePlaceholederLabel.isHidden = true
            
        default:
            break
        }
    }
}
