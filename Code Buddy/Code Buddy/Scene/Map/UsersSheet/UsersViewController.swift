#warning("Fixed hard coded")
import UIKit

final class UsersViewController: UIViewController {
    
    enum Section {
        case main
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MOCK DATA
    let mockNames: [String] = ["Ahmet","Mehmet","Ayşe","Fatma","Mustafa","Zeynep","Ali","Şehrazat","Cem","Elif"]
    
    let mockSoftwareTitles: [String] = [
        "CodeMaster","DataForge","ByteGenius","LogicCraft","SwiftNinja","AppWizard","TechSculptor","InnovateHub","BitHarbor","EpicCoder" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        
    }
    
    private func setupUI() {
        
        
        // MARK: - CollectionView Configuration
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .black

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
        return mockNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCollectionViewID", for: indexPath) as! UserCollectionViewCell

        let image = UIImage(named: "fv")
        let name = mockNames[indexPath.row]
        let title = mockSoftwareTitles[indexPath.row]
        cell.setCell(image: image!, name: name, title: title)
        return cell
    }

}
