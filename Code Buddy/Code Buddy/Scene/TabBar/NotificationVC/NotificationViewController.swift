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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        
    }
    
    private func createUI() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        notificationTableView.delegate = self
        notificationTableView.dataSource = self
        notificationTableView.backgroundColor = UIColor(named: "BackgroundColor")
        
    }

    

}

extension NotificationViewController: UITableViewDelegate {
    
}

extension NotificationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Notificaiton View"
        cell.backgroundColor = UIColor(named: "BackgroundColor")
        return cell
    }
    
    
}
