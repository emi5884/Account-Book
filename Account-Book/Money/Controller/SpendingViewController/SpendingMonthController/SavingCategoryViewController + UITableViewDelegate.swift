import UIKit

// MARK: - UITableViewDataSource

extension SavingCategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SavingCategoryViewCell
        cell.viewModel = ItemViewModel(item: items[indexPath.row], cellNumber: indexPath.row)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SavingCategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

