import UIKit

class TopViewController: UIViewController {
    
    // MARK: - Properties
    
    public let shoppingListIdentifier = "identifier"
    public var topViewHeader: TopViewHeader?
    
    public lazy var shoppingListView: BaseTableView = {
        let tv = BaseTableView()
        tv.backgroundColor = .customNavyBlue()
        tv.delegate = self
        tv.dataSource = self
        tv.register(TopViewCell.self, forCellReuseIdentifier: shoppingListIdentifier)
        tv.bounces = false
        
        let headerFrame = CGRect(x: 0, y: 0, width: view.frame.width,  height: 319)
        topViewHeader = TopViewHeader(frame: headerFrame)
        topViewHeader?.delegate = self
        
        tv.tableHeaderView = topViewHeader
        return tv
    }()
    
    public var selectedCellNumber = 0
    
    public lazy var newItemInputView: CustomInputView = {
        let view = CustomInputView()
        view.delegate = self
        return view
    }()
    
    public var categeoryBar = CategeoryBar()
    public var selectedCategoryImageUrl: String = ""
    
    public var spendingType: SpendingType = .variable
    private var allCategories: [Category] = []
    private var variableCategories : [Category] = []
    private var fixedCategories : [Category] = []
    
    public lazy var categoryListView: CategoryListView = {
        let view = CategoryListView()
        view.layer.shadowRadius = 20
        view.layer.shadowOpacity = 0.4
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.delegate = self
        return view
    }()
    
    public lazy var backgroundView = UIView.createBackgroundView(target: self, action: #selector(didTapBackground))
    public lazy var categoryViewHeight: CGFloat = view.frame.height - 300 - Dimension.safeAreaTopHeight
    
    public lazy var customAlert: CustomAlert = {
        let alert = CustomAlert()
        alert.delegate = self
        alert.alpha = 0
        return alert
    }()
    
    public lazy var backgroundForInput: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.isHidden = true
        button.addTarget(self, action: #selector(didTapInputBackground), for: .touchUpInside)
        return button
    }()
    
    public var shouldShowAlertView = false
    
    public var allItems: [Item] = [] {
        didSet { shoppingListView.reloadData() }
    }
    
    public var selectedItems: [Item] = []
    
    public var historyItems: [HistoryItem] = []
    public var selectedHistoryItems: [HistoryItem] = []
    
    public  let inputCloseButtonHeight: CGFloat = 50
    private let inputHeight: CGFloat = 120
    
    public var shoppingListViewTopConstraint: NSLayoutConstraint?
    public var shoppingListViewBottomConstraint : NSLayoutConstraint?
    public var newItemInputViewBottomConstraint: NSLayoutConstraint?
    
    public lazy var defaultIncome = 0 {
        didSet { topViewHeader?.setIncomePriceLabel(price: defaultIncome) }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCategories()
        fetchHistoryItem()
        configureUI()
        setupConstraint()
        keyboardNotification()
        
        defaultIncome = UserDefaults.standard.integer(forKey: "incomeSome")
        topViewHeader?.setIncomePriceLabel(price: defaultIncome)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let isCategoryListOpen = categoryListView.frame.origin.y < view.frame.height
        let isAlertShowing = customAlert.alpha == 1
        
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.backgroundView.alpha = 0
            
            if isCategoryListOpen {
                self.categoryListView.frame.origin.y = self.view.frame.height
                
            } else if isAlertShowing {
                self.customAlert.alpha = 0
            }
        }
    }
    
    // MARK: - API
    
    func uploadNewCategory(image: UIImage, cell: CategoryListCell) {
        showLoader(true)
        
        let info = CategoryInfo(categoryImage: image, type: spendingType.text)
        
        CategoryService.uploadCategory(categoryInfo: info) { imageUrl in
            let newCategory = Category(data: ["imageUrl": imageUrl])
            
            if self.spendingType == .variable {
                self.variableCategories.append(newCategory)
                self.categeoryBar.selectNewCategory(categories: self.variableCategories)
            } else {
                self.fixedCategories.append(newCategory)
                self.categeoryBar.selectNewCategory(categories: self.fixedCategories)
            }
            
            self.showLoader(false)
            cell.isSelected = false
            
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
                self.backgroundView.alpha = 0
                self.categoryListView.frame.origin.y = self.view.frame.height
            }
        }
    }
    
    func fetchCategories() {
        CategoryService.fetchCategories { categories in
            self.allCategories = categories
            
            categories.forEach { category in
                if category.type == "variable" {
                    self.variableCategories.append(category)
                } else {
                    self.fixedCategories.append(category)
                }
            }
            
            guard let firstCategory = self.variableCategories.first else { return }
            self.selectedCategoryImageUrl = firstCategory.imageUrl
            self.categeoryBar.changeSpendingType(categories: self.variableCategories)
            
            self.fetchItem()
        }
    }
    
    func fetchItem() {
        ItemService.fetchItem { items in
            self.allItems = items
            self.swapListCategory()
            self.changeSpendingSum(item: nil)
        }
    }
    
    func uploadItem(data: [String: Any]) {
        ItemService.uploadItem(data: data) { item in
            self.allItems.insert(item, at: 0)
            self.swapListCategory()
            
            if item.isChecked {
                self.changeSpendingSum(item: item)
                self.uploadHistoryItem(item: item)
            }
        }
    }
    
    func editItem(item: Item) {
        ItemService.editItem(item: item) { newItem in
            self.allItems = newItem
            
            self.shoppingListView.reloadData()
            self.dismissAlert()
            
            self.changeSpendingSum(item: nil)
        }
    }
    
    func changeCheckValue(item: Item) {
        let isHistoryItemExist = isHistoryItemExist(item: item)
        
        ItemService.changeCheckValue(item: item,
                                     shouldAddHistory: !isHistoryItemExist) { _ in
            self.fetchHistoryItem()
            self.fetchItem()
        }
    }
    
    func fetchHistoryItem() {
        self.selectedHistoryItems = []
        
        HistoryService.fetchHistoryItem { historyItems in
            self.historyItems = historyItems
            
            historyItems.forEach { item in
                if self.selectedCategoryImageUrl == item.categoryUrl {
                    self.selectedHistoryItems.append(item)
                }
            }
        }
    }
    
    func uploadHistoryItem(item: Item) {
        
        let isHistoryItemExist = isHistoryItemExist(item: item)
        if isHistoryItemExist { return }
        
        HistoryService.uploadHistoryItem(item: item) { error in
            if let error = error {
                print("failed to upload: \(error.localizedDescription)")
                return
            }
            self.fetchHistoryItem()
        }
    }
    
    func uploadSpending(savingValue: Int) {
        
        let categoriesString = allCategories.map { $0.imageUrl }
        let info = SpendingInfo(cost: savingValue, categories: categoriesString)
        
        SpendingService.uploadSpending(spendingInfo: info) { error in
            if let error = error {
                print("failed to upload saving: \(error.localizedDescription)")
                return
            }
        }
    }
    
    func uploadSaving(savingValue: Int) {
        SavingService.uploadSaving(value: savingValue) { error in
            if let error = error {
                print("failed to upload: \(error.localizedDescription)")
                return
            }
        }
    }
    
    // MARK: - Action
    
    @objc func didTapBackground() {
        view.endEditing(true)
        
        UIView.animate(withDuration: 0.25) {
            self.customAlert.frame.origin.y += 80
        }
    }
    
    @objc func didTapInputBackground() {
        view.endEditing(true)
        newItemInputView.namePlaceholederLabel.isHidden = false
    }
    
    // MARK: - Helper
    
    func configureUI() {
        view.backgroundColor = .customWhite()
        
        view.addSubview(newItemInputView)
        newItemInputView.anchor(left: view.leftAnchor,
                                bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                right: view.rightAnchor,
                                height: inputHeight)
        
        view.addSubview(shoppingListView)
        shoppingListView.anchor(top: view.topAnchor,
                                left: view.leftAnchor,
                                bottom: newItemInputView.topAnchor,
                                right: view.rightAnchor,
                                paddingTop: -Dimension.safeAreaTop,
                                paddingBottom: -inputCloseButtonHeight)
        
        view.addSubview(backgroundView)
        backgroundView.fillSuperview()
        
        view.addSubview(categoryListView)
        categoryListView.frame = CGRect(x: 0, y: view.frame.height,
                                        width: view.frame.width,
                                        height: categoryViewHeight)
        
        view.addSubview(customAlert)
        customAlert.frame = CGRect(x: 0, y: 0, width: view.frame.width - 60, height: 240)
        customAlert.center.x = view.frame.width / 2
        customAlert.center.y = view.frame.height / 2
        
        shoppingListView.addSubview(backgroundForInput)
        backgroundForInput.anchor(top: view.topAnchor,
                                  left: view.leftAnchor,
                                  right: view.rightAnchor,
                                  height: view.frame.height - Dimension.keyboardHeight)
    }
    
    func showAlert() {
        shouldShowAlertView = true
        
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.backgroundView.alpha = 1
            self.customAlert.alpha = 1
        }
    }
    
    func dismissAlert() {
        shouldShowAlertView = false
        customAlert.alreadyEditing = false
        
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.view.endEditing(true)
            self.backgroundView.alpha = 0
            self.customAlert.alpha = 0
            self.customAlert.center.y = self.view.frame.height / 2
        }
    }
    
    func changeSpendingSum(item: Item?) {
        var prices: [Int] = []
        allItems.forEach { if $0.isChecked { prices.append($0.price) }}
        
        let sum = prices.reduce(0) { $0 + $1 }
        self.topViewHeader?.setSpendingPriceLabel(price: sum)
    }
    
    func swapListCategory() {
        self.selectedItems = []
        
        allItems.forEach { item in
            if item.categoryUrl == selectedCategoryImageUrl &&
                item.spendingType == self.spendingType.text {
                self.selectedItems.append(item)
            }
        }
        self.shoppingListView.reloadData()
    }
    
    func changeCategory(spendingType: SpendingType) {
        self.spendingType = spendingType
        
        if spendingType == .variable {
            guard let firstCategory = self.variableCategories.first else { return }
            self.selectedCategoryImageUrl = firstCategory.imageUrl
            self.categeoryBar.changeSpendingType(categories: self.variableCategories)
        } else {
            if let firstCategory = self.fixedCategories.first {
                self.selectedCategoryImageUrl = firstCategory.imageUrl
            } else {
                self.selectedCategoryImageUrl = ""
            }
            self.categeoryBar.changeSpendingType(categories: self.fixedCategories)
        }
        
        swapListCategory()
    }
    
    func swapHistoryCategory() {
        self.selectedHistoryItems = []
        
        historyItems.forEach { item in
            if item.categoryUrl == selectedCategoryImageUrl &&
                item.spendingType == self.spendingType.text {
                self.selectedHistoryItems.append(item)
            }
        }
        
        self.shoppingListView.reloadData()
    }
    
    func isHistoryItemExist(item: Item) -> Bool {
        var isExist = false
        
        for historyItem in selectedHistoryItems {
            if item.name == historyItem.name
                && item.price == historyItem.price
                && item.categoryUrl == historyItem.categoryUrl {
                
                isExist = true
                break
            }
        }
        return isExist
    }
}

