//
//  SplashScreenViewController.swift
//  Code Buddy
//
//  Created by furkan vural on 29.02.2024.
//

import UIKit

final class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        checkOnboardingPageCompleted()
        
    }
    
    private func checkOnboardingPageCompleted() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let hasSeenOnboarding = UserDefaults.standard.bool(forKey: "isSeenOnboarding")
            hasSeenOnboarding ? self.showMainPage() : self.showOnboardingPage()
        }
        
    }
    
    private func showMainPage() {
        performSegue(withIdentifier: "toMainVC", sender: nil)
    }
    
    private func showOnboardingPage() {
        performSegue(withIdentifier: "toFirstOnboardingVC", sender: nil)
    }

}
