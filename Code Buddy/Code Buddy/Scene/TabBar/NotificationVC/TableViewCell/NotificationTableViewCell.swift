//
//  NotificationTableViewCell.swift
//  Code Buddy
//
//  Created by furkan vural on 23.03.2024.
//

import UIKit

protocol NotificationViewControllerDelegate: AnyObject {
    func waveButtonTapped(indexPath: IndexPath)
}

final class NotificationTableViewCell: UITableViewCell {

    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var notificationTitle: UILabel!
    
    weak var delegate: NotificationViewControllerDelegate?
    var indexPath: IndexPath!
    
    func configure(with image: UIImage?, title: String) {
        
        contentView.backgroundColor = UIColor(named: "BackgroundColor")
        
        profileImage.image = image
        notificationTitle.text = title
        
        profileImage.setRounded()
    }
    
    @IBAction func waveButtonClicked(_ sender: Any) {
        
        delegate?.waveButtonTapped(indexPath: indexPath)
    }
    
}
