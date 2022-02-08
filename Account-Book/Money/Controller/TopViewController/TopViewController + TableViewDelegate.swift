import UIKit

// MARK: - UITableViewDataSource

extension TopViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        categeoryBar.categeoryBarDelegate = self
        return categeoryBar
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: shoppingListIdentifier, for: indexPath) as! TopViewCell
        cell.viewModel = ItemViewModel(item: selectedItems[indexPath.row], cellNumber: indexPath.row)
        cell.delegate = self
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TopViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCellNumber = indexPath.row
        
        let name = selectedItems[indexPath.row].name
        let price = selectedItems[indexPath.row].price
        customAlert.setItemInfo(info: ItemInfo(name: name, price: price))
        
        showAlert()
    }
}
