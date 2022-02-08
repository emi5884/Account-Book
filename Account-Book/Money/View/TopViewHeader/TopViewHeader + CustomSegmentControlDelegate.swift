import UIKit

extension TopViewHeader: CustomSegmentControlDelegate {
    func changeSegmentValue(spendingType: SpendingType) {
        delegate?.changeSegmentedValue(spendingType: spendingType)
    }
}
