import UIKit

extension IncomeViewController: CustomAlertDelegate {
    func beginEditing() {
        UIView.animate(withDuration: 0.25) {
            self.incomeAlert.frame.origin.y -= 80
        }
    }
    
    func didTapOkButton(alert: CustomAlert) {
        guard let incomeInfo = alert.incomeInfo() else { return }
        registerIncome(incomeInfo: incomeInfo)
    }
    
    func didTapCancelButton() {
        dismissAlert()
    }
}
