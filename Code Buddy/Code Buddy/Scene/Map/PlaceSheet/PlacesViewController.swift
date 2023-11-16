//
//  PlacesViewController.swift
//  Code Buddy
//
//  Created by furkan vural on 15.11.2023.
//

import UIKit

class PlacesViewController: UIViewController {

    @IBOutlet weak var placesSegmentedController: UISegmentedControl!
    
    @IBOutlet weak var placesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placesTableView.delegate = self
        placesTableView.dataSource = self
        setupSegmentedController()
      
    }
    
    private func setupSegmentedController() {
        placesSegmentedController.setTitle("Favorite", forSegmentAt: 0)
        placesSegmentedController.setTitle("Best", forSegmentAt: 1)
    }
 
    @IBAction func placesSegmentedControllerClicked(_ sender: Any) {
    }
    
}

extension PlacesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "XYZ Places"
        cell.detailTextLabel?.text = "Kadıköy"
        return cell
    }
    
    
}
