//
//  UsersViewController.swift
//  Code Buddy
//
//  Created by furkan vural on 24.11.2023.
//

import UIKit

class UsersViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.minimumLineSpacing = 0
        
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = screenWidth / 3
        
        collectionViewLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        collectionView.collectionViewLayout = collectionViewLayout
        
    }
}

extension UsersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCollectionViewID", for: indexPath) as! UserCollectionViewCell
        
        cell.userImageView.image = UIImage(named: "fv")
        
        cell.userNameLabel.text = "Furkan Vural"
        cell.userTitleLabel.text = "Frontend Developers"
        
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.borderWidth = 0.4
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
}
