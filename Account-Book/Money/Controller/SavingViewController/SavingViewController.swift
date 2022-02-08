import UIKit

class SavingViewController: UIViewController {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel.createBoldFontLabel(text: "貯蓄", size: 24)
    private let priceLabel = UILabel.createBoldFontLabel(text: "", size: 20)
    
    private let closeButton = UIButton.createImageButton(image: #imageLiteral(resourceName: "old-close"), target: self, selector: #selector(didTapCloseButton))
    
    public let identifier = "identifier"
    private lazy var tableView: BaseTableView = {
        let tv = BaseTableView()
        tv.dataSource = self
        tv.register(SavingCell.self, forCellReuseIdentifier: identifier)
        return tv
    }()
    
    public var savings: [SavingMonth] = []
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchSaving()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Action
    
    @objc func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - API
    
    func fetchSaving() {
        SavingService.fetchSaving { saving in
            self.savings = saving.savings
            self.tableView.reloadData()
            
            self.configureViewModel(savingSum: saving.savingSum)
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .customNavyBlue()
        
        let titleStackView = UIStackView(arrangedSubviews: [titleLabel, priceLabel])
        titleStackView.distribution = .fillEqually
        titleStackView.axis = .vertical
        titleStackView.backgroundColor = .customNavyBlue()
        
        view.addSubview(titleStackView)
        titleStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              left: view.leftAnchor,
                              right: view.rightAnchor,
                              paddingTop: 10,
                              height: 100)
        
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                           left: view.leftAnchor,
                           paddingTop: 20,
                           paddingLeft: 10)
        closeButton.setDimensions(height: 50, width: 50)
        
        view.addSubview(tableView)
        tableView.anchor(top: titleStackView.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor)
    }
    
    func configureViewModel(savingSum: Int) {
        let textAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.banana(size: 20), .kern: 5, .foregroundColor: UIColor.customYellow()]
        let priceAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.abraham(size: 24), .kern: 5, .foregroundColor: UIColor.customYellow()]
        let attributedText = NSMutableAttributedString(string: "￥ ", attributes: textAttributes)
        attributedText.append(NSAttributedString(string: "\(savingSum)", attributes: priceAttributes))
        priceLabel.attributedText = attributedText
    }
}
