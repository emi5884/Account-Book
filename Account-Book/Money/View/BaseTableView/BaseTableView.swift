import UIKit

class BaseTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        rowHeight = 70
        showsVerticalScrollIndicator = false
        backgroundColor = .customNavyBlue()
        separatorColor = .white.withAlphaComponent(0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
