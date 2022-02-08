import UIKit
import FirebaseStorage

struct ImageUploader {
    
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let data = image.pngData() else { return }
        let fileName = UUID().uuidString
        
        let ref = Storage.storage().reference(withPath: "category_image/\(fileName)")
        
        ref.putData(data, metadata: nil) { _, error in
            if let error = error {
                print("failed to upload: \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { imageUrl, _ in
                guard let imageUrlString = imageUrl?.absoluteString else { return }
                completion(imageUrlString)
            }
        }
    }
 }
