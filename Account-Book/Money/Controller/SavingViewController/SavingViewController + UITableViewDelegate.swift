import UIKit

// MARK: - UITableViewDataSource

extension SavingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SavingCell
        cell.viewModel = SavingViewModel(saving: savings[indexPath.row])
        return cell
    }
}
