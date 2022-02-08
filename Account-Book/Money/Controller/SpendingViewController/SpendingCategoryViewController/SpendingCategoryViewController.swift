import UIKit
import SDWebImage

class SpendingCategoryViewController: UIViewController {
    
    // MARK: - Properties
    
    private let categoryImage = UIButton.createImageView(image: #imageLiteral(resourceName: "history"), radius: 50)
    private let priceLabel = UILabel.createBoldFontLabel(text: "", size: 30)
    
    private let closeButton = UIButton.createImageButton(image: #imageLiteral(resourceName: "arrow-left"), target: self, selector: #selector(didTapCloseButton))
    
    public let identifier = "identifier"
    private lazy var tableView: BaseTableView = {
        let tv = BaseTableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(SpendingCategoryViewCell.self, forCellReuseIdentifier: identifier)
        return tv
    }()
    
    public let items: [Item]
    
    // MARK: - Lifecycle
    
    init(viewModel: SpendingMonthViewModel) {
        self.items = viewModel.items
        categoryImage.sd_setImage(with: viewModel.categoryImage, for: .normal, completed: nil)
        categoryImage.backgroundColor = .customYellow()
        categoryImage.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        let textAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.banana(size: 24), .kern: 1, .foregroundColor: UIColor.customYellow()]
        let numberAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.abraham(size: 24), .kern: 3, .foregroundColor: UIColor.customYellow()]
        let attributedText = NSMutableAttributedString(string: "￥ ", attributes: textAttributes)
        attributedText.append(NSAttributedString(string: "\(viewModel.spendingSum)", attributes: numberAttributes))
        priceLabel.attributedText = attributedText
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Action
    
    @objc func didTapCloseButton() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .customNavyBlue()
        
        view.addSubview(categoryImage)
        categoryImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10)
        categoryImage.centerX(inView: view)
        categoryImage.setDimensions(height: 100, width: 100)
        
        view.addSubview(priceLabel)
        priceLabel.anchor(top: categoryImage.bottomAnchor, paddingTop: 10)
        priceLabel.setDimensions(height: 50, width: view.frame.width)
        
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                           left: view.leftAnchor,
                           paddingTop: 20,
                           paddingLeft: 10)
        closeButton.setDimensions(height: 50, width: 50)
        
        view.addSubview(tableView)
        tableView.anchor(top: priceLabel.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor)
    }
}
