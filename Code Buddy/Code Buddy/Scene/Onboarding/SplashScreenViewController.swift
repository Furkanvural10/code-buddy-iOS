//
//  SplashScreenViewController.swift
//  Code Buddy
//
//  Created by furkan vural on 29.02.2024.
//

import UIKit
import Lottie

final class SplashScreenViewController: UIViewController {
    
    // MARK: - UI Component
    @IBOutlet private weak var animationView: LottieAnimationView!
    @IBOutlet private weak var appNameLabel: UILabel!
    
    private let appNameString = ["<","C","o","d","e","B","u","d","d","y",">"]

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .red
        configurationUI()
        checkOnboardingPageCompleted()
    }
    
    override func viewDidAppear(_ animated: Bool) {

        for char in appNameString {
            appNameLabel.text! += "\(char)"
            RunLoop.current.run(until: Date() + 0.14)
        }
        animationView.contentMode = .center
        animationView.play()
    }
    
    private func configurationUI() {
//        appNameLabel.font = .boldSystemFont(ofSize: 30)
        appNameLabel.textColor = .white
        appNameLabel.font = .getAntaFont(size: 30)
//        animationView.loopMode = .loop
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
