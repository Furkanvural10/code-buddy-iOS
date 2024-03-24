//
//  NotificationViewController.swift
//  Code Buddy
//
//  Created by furkan vural on 20.03.2024.
//

import UIKit

final class NotificationViewController: UIViewController {
    
    // MARK: - Notification Title
    @IBOutlet weak var notificationTitle: UILabel!
    
    // MARK: - TableView
    @IBOutlet weak var notificationTableView: UITableView!
    
    // MARK: - Properties
    private let cellIdentifier = "CustomCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notification"
        createUI()
    }
    
    private func createUI() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        notificationTableView.delegate = self
        notificationTableView.dataSource = self
        notificationTableView.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    private func sendNotification() {
        
    }
}

extension NotificationViewController: UITableViewDelegate { }

extension NotificationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NotificationTableViewCell
        let image = UIImage(named: "fv")
        cell.configure(with: image, title: "Furkan Vural wave you. 1h", detail: "Wave Back")
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 90 }

}

extension NotificationViewController: NotificationViewControllerDelegate {
    func waveButtonTapped(indexPath: IndexPath) {
        print("İndex path: \(indexPath)")
        showAlertMessage()
    }
    
    private func showAlertMessage() {
        
        let alertController = UIAlertController(title: "Ali Kaşıkçı will be notified", message: "Are you sure?", preferredStyle: .actionSheet)
        let waveButton = UIAlertAction(title: "Wave", style: .default) { _ in
            self.sendNotification()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive)
        alertController.addAction(waveButton)
        alertController.addAction(cancel)
        self.present(alertController, animated: true)
    }
    
    @objc private func dismissActionSheet() {
        self.dismiss(animated: true)
    }

}
