import UIKit

// MARK: - UITableViewDataSource

extension SpendingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spendings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SpendingCell
        cell.viewModel = SpendingViewModel(saving: spendings[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SpendingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = SpendingMonthViewController(spending: spendings[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
