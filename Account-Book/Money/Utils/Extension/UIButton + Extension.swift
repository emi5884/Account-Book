import UIKit

extension UIButton {
    
    static func createImageButton(image: UIImage, target: Any?, selector: Selector) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.addTarget(target, action: selector, for: .touchUpInside)
        return button
    }
    
    static func createImageView(image: UIImage, radius: CGFloat) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        button.layer.cornerRadius = radius
        button.isUserInteractionEnabled = false
        return button
    }
    
    static func createTextButton(text: String, target: Any?, selector: Selector) -> UIButton {
        let button = UIButton()
        button.addTarget(target, action: selector, for: .touchUpInside)
        button.backgroundColor = .customLightNavyBlue()
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.banana(size: 17), .kern: 3, .foregroundColor: UIColor.white]
        let attributedTitle = NSAttributedString(string: text, attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }
}
