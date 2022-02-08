import UIKit

protocol TopViewHeaderDelegate {
    func showIncomeView()
    func showSpendingView()
    func showSavingView()
    func changeSegmentedValue(spendingType: SpendingType)
    func uploadNewValues(spendingValue: Int, savingValue: Int)
}

struct CalculateInfo {
    let income: Int
    let spending: Int
}

enum PriceType {
    case income
    case spending
    case saving
}

class TopViewHeader: UIView {
    
    // MARK: - Properties
    
    public var delegate: TopViewHeaderDelegate?
    
    private var incomePriceLabel = UILabel()
    private var spendingPriceLabel = UILabel()
    private var savingPriceLabel = UILabel()
    
    private let monthLabelText = DateFormatter.titleMonth(date: Date())
    private lazy var monthLabel = UILabel.createMonthLabel(text: monthLabelText, size: 30)
    private lazy var incomeStackView = createStackView(moneyType: .income, priceType: .income)
    private lazy var spendingStackView = createStackView(moneyType: .spending, priceType: .spending)
    private lazy var savingStackView = createStackView(moneyType: .saving, priceType: .saving)
    private lazy var minusSymbol = createSymbolLabel(symbol: "-")
    private lazy var equalSymbol = createSymbolLabel(symbol: "=")
    
    public let categoryViewIdentifier = "identifier"
    private lazy var categoryView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: categoryViewIdentifier)
        return cv
    }()
    
    private let triangleView = TriangleView()
    
    private let segmentBackgroundView = UIView()
    private lazy var segmentControl: CustomSegmentControl = {
        let cs = CustomSegmentControl()
        cs.delegate = self
        cs.layer.cornerRadius = 30
        cs.backgroundColor = .customLightNavyBlue()
        return cs
    }()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc func showIncomeView() {
        delegate?.showIncomeView()
    }
    
    @objc func showSpendingView() {
        delegate?.showSpendingView()
    }
    
    @objc func showSavingView() {
        delegate?.showSavingView()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        backgroundColor = .customLightNavyBlue()
        
        addSubview(monthLabel)
        monthLabel.anchor(top: safeAreaLayoutGuide.topAnchor,
                          paddingTop: Dimension.safeAreaTop)
        monthLabel.centerX(inView: self)
        
        let stackView = UIStackView(arrangedSubviews: [incomeStackView,
                                                       minusSymbol,
                                                       spendingStackView,
                                                       equalSymbol,
                                                       savingStackView])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        
        addSubview(stackView)
        stackView.anchor(top: monthLabel.bottomAnchor,
                         left: leftAnchor,
                         right: rightAnchor,
                         paddingTop: 15,
                         paddingLeft: 20,
                         paddingRight: 20,
                         height: 62)
        
        addSubview(triangleView)
        triangleView.backgroundColor = .customLightNavyBlue()
        triangleView.anchor(top: stackView.bottomAnchor,
                            paddingTop: 15)
        triangleView.centerX(inView: self)
        triangleView.setDimensions(height: 30, width: 30)
        
        addSubview(segmentBackgroundView)
        segmentBackgroundView.backgroundColor = .customNavyBlue()
        segmentBackgroundView.anchor(top: triangleView.bottomAnchor,
                                     left: leftAnchor,
                                     right: rightAnchor,
                                     height: 110)
        
        addSubview(segmentControl)
        segmentControl.anchor(top: triangleView.bottomAnchor,
                              paddingTop: 30)
        segmentControl.centerX(inView: self)
        segmentControl.setDimensions(height: 60, width: 200)
    }
    
    func createStackView(moneyType: MoneyType, priceType: PriceType) -> UIStackView {
        
        let priceLabel = UILabel()
        
        switch moneyType {
        case .income:
            incomePriceLabel = priceLabel
        case .spending:
            spendingPriceLabel = priceLabel
        case .saving:
            savingPriceLabel = priceLabel
        }

        priceLabel.textColor = .white
        priceLabel.attributedText = createAttributesText(price: 000)
        
        
        let titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.textColor = .white
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.banana(size: 13), .kern: 1]
        titleLabel.attributedText = NSAttributedString(string: moneyType.title, attributes: attributes)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, priceLabel])
        stackView.spacing = 0
        stackView.axis = .vertical
        
        switch priceType {
        case .income:
            let tap = UITapGestureRecognizer(target: self, action: #selector(showIncomeView))
            stackView.addGestureRecognizer(tap)
        case .spending:
            let tap = UITapGestureRecognizer(target: self, action: #selector(showSpendingView))
            stackView.addGestureRecognizer(tap)
        case .saving:
            let tap = UITapGestureRecognizer(target: self, action: #selector(showSavingView))
            stackView.addGestureRecognizer(tap)
        }
        
        return stackView
    }
    
    func createSymbolLabel(symbol: String) -> UILabel {
        let label = UILabel()
        label.textColor = .white
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.digitalFont(size: 26), .kern: 1]
        label.attributedText = NSAttributedString(string: symbol, attributes: attributes)
        return label
    }
    
    func setIncomePriceLabel(price: Int) {
        incomePriceLabel.attributedText  = createAttributesText(price: price)
        calculateSaving(fromInput: true)
    }
    
    func setSpendingPriceLabel(price: Int) {
        spendingPriceLabel.attributedText  = createAttributesText(price: price)
        calculateSaving(fromInput: false)
    }
    
    func calculateSaving(fromInput: Bool) {
        guard let budgetInfo = budgetStringToInt() else { return }
        
        let saving = budgetInfo.income - budgetInfo.spending
        savingPriceLabel.attributedText  = createAttributesText(price: saving)
        
        delegate?.uploadNewValues(spendingValue: budgetInfo.spending, savingValue: saving)
    }
    
    func budgetStringToInt() -> CalculateInfo? {
        
        guard let incomeString = incomePriceLabel.text?
                .replacingOccurrences(of: "￥ 000,000", with: "0")
                .replacingOccurrences(of: "￥ ", with: "") else { return nil }
        
        guard let spendingString = spendingPriceLabel.text?
                .replacingOccurrences(of: "￥ 000,000", with: "0")
                .replacingOccurrences(of: "￥ ", with: "") else { return nil }
        
        guard let income = Int(incomeString) else { return nil }
        guard let spending = Int(spendingString) else { return nil }
        
        return CalculateInfo(income: income, spending: spending)
    }
    
    func createAttributesText(price: Int) -> NSAttributedString {
        let enAttribute: [NSAttributedString.Key: Any] = [.font: UIFont.banana(size: 16)]
        let priceAttribute: [NSAttributedString.Key: Any] = [.font: UIFont.digitalFont(size: 22), .kern: 1]
        let priceText = NSMutableAttributedString(string: "￥ ", attributes: enAttribute)
        priceText.append(NSAttributedString(string: "\(price)", attributes: priceAttribute))
        return priceText
    }
}
