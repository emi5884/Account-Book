import UIKit

extension UILabel {
    
    static func createBoldFontLabel(text: String, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: size)
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.banana(size: size), .kern: 1]
        label.attributedText = NSAttributedString(string: text, attributes: attributes)
        
        return label
    }
    
    static func createMonthLabel(text: String, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: size)
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.banana(size: size), .kern: 8]
        label.attributedText = NSAttributedString(string: text, attributes: attributes)
        
        return label
    }
}
