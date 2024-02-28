//
//  SecondOnboardingViewController.swift
//  Code Buddy
//
//  Created by furkan vural on 28.02.2024.
//

import UIKit

final class SecondOnboardingViewController: UIViewController {

    @IBOutlet private weak var secondOnboardingImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()

        
    }
    
    private func setupUI() {
        
        // MARK: - Top Bar Item Configuration
        navigationItem.hidesBackButton = true
        
        // MARK: - UIImage Configuration
        secondOnboardingImage.layer.zPosition = -1
        secondOnboardingImage.contentMode = .scaleAspectFit
        secondOnboardingImage.contentMode = .scaleAspectFit
        
        // MARK: - TitleLabel Configuration
        titleLabel.adjustsFontSizeToFitWidth = true
        
        // MARK: - MessageLabel Configuration
        titleLabel.adjustsFontSizeToFitWidth = true
        
        
        
        
        
    }
    
    @IBAction func finishedOnboardingButtonClicked(_ sender: Any) {
        
    }
    
}

