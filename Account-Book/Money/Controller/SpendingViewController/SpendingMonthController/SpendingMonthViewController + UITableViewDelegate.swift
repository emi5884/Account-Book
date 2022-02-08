import UIKit

// MARK: - UITableViewDataSource

extension SpendingMonthViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spendingMonths.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SpendingMonthViewCell
        cell.viewModel = SpendingMonthViewModel(spending: spendingMonths[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SpendingMonthViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = SpendingMonthViewModel(spending: spendingMonths[indexPath.row])
        let vc = SpendingCategoryViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}
