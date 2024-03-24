import UIKit
import Foundation

protocol UserCollectionViewCellProtocol {
    func setCell(image: UIImage, name: String, title: String)
}


final class UserCollectionViewCell: UICollectionViewCell, UserCollectionViewCellProtocol {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userTitleLabel: UILabel!
    
    func setCell(image: UIImage, name: String, title: String) {
        
        userNameLabel.textColor = .white
        userTitleLabel.textColor = .white.withAlphaComponent(0.8)
        
        let originalImage = image
        let resizedImage = originalImage.resized(to: CGSize(width: 30, height: 30))
        
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 0.4
        layer.cornerRadius = 10
        
        userImageView.image = resizedImage
        userNameLabel.text = name
        userTitleLabel.text = title
        
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
        userImageView.clipsToBounds = true
    }
    
}
