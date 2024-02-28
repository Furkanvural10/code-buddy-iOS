//
//  FirstOnboardingViewController.swift
//  Code Buddy
//
//  Created by furkan vural on 28.02.2024.
//

import UIKit

final class FirstOnboardingViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        
    }
    
    private func setupUI() {
        backgroundImage.image = UIImage(named: "img_onboarding1")
        backgroundImage.layer.zPosition = -1
        backgroundImage.contentMode = .scaleAspectFit
    }
    



}
