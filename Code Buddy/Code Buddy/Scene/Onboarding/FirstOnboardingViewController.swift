//
//  FirstOnboardingViewController.swift
//  Code Buddy
//
//  Created by furkan vural on 28.02.2024.
//

#warning("Fix hard coded")

import UIKit

final class FirstOnboardingViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        
    }
    
    private func setupUI() {
        
        // MARK: - Background Image Configuration
        backgroundImage.layer.zPosition = -1
        backgroundImage.contentMode = .scaleAspectFit
        
        // MARK: - Title Label Configuration
        titleLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: - Message Label Configuration
        messageLabel.adjustsFontSizeToFitWidth = true
        
        
        
        
    }
    
    
    
    @IBAction func continueButtonClicked(_ sender: Any) {
        
    }
    


}
