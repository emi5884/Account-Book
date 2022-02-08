import UIKit

extension UIImageView {
    
    static func createImageView(image: UIImage, radius: CGFloat) -> UIImageView {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = radius
        iv.image = image
        iv.clipsToBounds = true
        iv.backgroundColor = .systemYellow
        return iv
    }
}
