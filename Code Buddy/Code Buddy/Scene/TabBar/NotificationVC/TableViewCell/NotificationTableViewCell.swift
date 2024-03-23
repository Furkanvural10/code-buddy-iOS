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
    @IBOutlet private weak var notificationDetail: UILabel!
    
    weak var delegate: NotificationViewControllerDelegate?
    var indexPath: IndexPath!
    
    func configure(with image: UIImage?, title: String, detail: String) {
        
        contentView.backgroundColor = UIColor(named: "BackgroundColor")
        
        profileImage.image = image
        notificationTitle.text = title
        notificationDetail.text = detail
        
        profileImage.setRounded()
    }
    
    @IBAction func waveButtonClicked(_ sender: Any) {
        
        delegate?.waveButtonTapped(indexPath: indexPath)
    }
    
}
