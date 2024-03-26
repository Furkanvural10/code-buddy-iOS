//
//  AppDelegate.swift
//  Code Buddy
//
//  Created by furkan vural on 7.11.2023.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        createUser()
//        window = UIWindow()
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let initialViewController = storyboard.instantiateViewController(withIdentifier: "SecondOnboardingViewController")
//        window?.rootViewController = initialViewController
//        window?.makeKeyAndVisible()
//        Thread.sleep(forTimeInterval: 3)
        return true
    }
    
    private func createUser() {
        guard let user = Auth.auth().currentUser else {
            print("Kullanıcı oluşturulma basladı")
            Auth.auth().signInAnonymously { result, error in
                guard error != nil else {
                    print("Kullanıcı oluşturulma bitti ✅")
                    return
                }
                print("Hata aldı tekrar deniyor.... ")
                self.createUser()
            }
            return
        }
        print("Kullanıcı var o yüzden oluşturulmadı ❌")
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

