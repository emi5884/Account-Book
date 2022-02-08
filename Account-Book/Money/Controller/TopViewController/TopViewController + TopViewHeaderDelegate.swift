import UIKit

extension TopViewController: TopViewHeaderDelegate {
    func uploadNewValues(spendingValue: Int, savingValue: Int) {
        uploadSpending(savingValue: spendingValue)
        uploadSaving(savingValue: savingValue)
    }

    func changeSegmentedValue(spendingType: SpendingType) {
        changeCategory(spendingType: spendingType)
    }
    
    func showIncomeView() {
        let vc = IncomeViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.priceSum = { sum in
            self.topViewHeader?.setIncomePriceLabel(price: sum)
        }
        present(vc, animated: true, completion: nil)
    }
    
    func showSpendingView() {
        let vc = SpendingViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    func showSavingView() {
        let vc = SavingViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
}
