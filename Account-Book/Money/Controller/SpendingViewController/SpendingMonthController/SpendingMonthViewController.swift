import UIKit

class SpendingMonthViewController: UIViewController {
    
    // MARK: - Properties
    
    private let monthLabel = UILabel.createBoldFontLabel(text: "", size: 24)
    private let priceLabel = UILabel.createBoldFontLabel(text: "", size: 20)
    
    private let closeButton = UIButton.createImageButton(image: #imageLiteral(resourceName: "arrow-left"), target: self, selector: #selector(didTapCloseButton))
    
    public let identifier = "identifier"
    private lazy var tableView: BaseTableView = {
        let tv = BaseTableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(SpendingMonthViewCell.self, forCellReuseIdentifier: identifier)
        return tv
    }()
    
    public var spendingMonths: [SpendingMonth] = []
    
    // MARK: - LifeCycle
    
    init(spending: Spending) {
        let monthAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.abraham(size: 27), .kern: 5, .foregroundColor: UIColor.white]
        monthLabel.attributedText = NSAttributedString(string: spending.date, attributes: monthAttributes)
        
        let textAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.banana(size: 20), .kern: 5, .foregroundColor: UIColor.customYellow()]
        let priceAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.abraham(size: 24), .kern: 5, .foregroundColor: UIColor.customYellow()]
        let attributedText = NSMutableAttributedString(string: "￥ ", attributes: textAttributes)
        attributedText.append(NSAttributedString(string: "\(spending.savingCost)", attributes: priceAttributes))
        priceLabel.attributedText = attributedText
        
        super.init(nibName: nil, bundle: nil)
        savingInfoForMonth(spendingDate: spending.date)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Action
    
    @objc func didTapCloseButton() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - API
    
    func savingInfoForMonth(spendingDate: String) {
        SpendingService.fetchCategories(date: spendingDate) { spendingMonths in
            self.spendingMonths = spendingMonths
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .customNavyBlue()
        
        let titleStackView = UIStackView(arrangedSubviews: [monthLabel, priceLabel])
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
}
