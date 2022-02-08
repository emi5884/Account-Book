import UIKit

// MARK: - UITableViewDataSource

extension IncomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incomes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! IncomeViewCell
        cell.viewModel = IncomeViewModel(income: incomes[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension IncomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? IncomeViewCell else { return }
        guard let incomeInfo = cell.returnIncomInfo() else { return }
        guard let incomeID = cell.viewModel?.income.incomeID else { return }
        
        incomeAlert.editIncome(info: incomeInfo)
        showAlert()
        
        incomeAlert.editCompletion = { incomeInfo in
            self.editIncome(incomeInfo: incomeInfo, incomeID: incomeID)
        }
    }
}
