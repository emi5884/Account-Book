import UIKit

struct SavingViewModel {
    let saving: SavingMonth
    
    var date: String {
        return saving.date
    }
    
    var price: Int {
        return saving.price
    }
    
    init(saving: SavingMonth) {
        self.saving = saving
    }
}
