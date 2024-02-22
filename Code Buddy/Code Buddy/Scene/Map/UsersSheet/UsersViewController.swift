#warning("Fixed hard coded")
import UIKit

final class UsersViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var searchBar: UISearchBar!
    
    
    // MOCK DATA
    let mockNames: [String] = ["Ahmet","Mehmet","Ayşe","Fatma","Mustafa","Zeynep","Ali","Şehrazat","Cem","Elif","Ahmet","Mehmet","Ayşe","Fatma","Mustafa","Zeynep","Ali","Şehrazat","Cem","Elif"]
    
    let mockSoftwareTitles: [String] = [
        "CodeMaster","DataForge","ByteGenius","LogicCraft","SwiftNinja","AppWizard","TechSculptor","InnovateHub","BitHarbor","EpicCoder","CodeMaster","DataForge","ByteGenius","LogicCraft","SwiftNinja","AppWizard","TechSculptor","InnovateHub","BitHarbor","EpicCoder"]
    
    private let customBlackColor = UIColor(named: "BackgroundColor")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = customBlackColor
        setupUI()
        
        
    }
    
    
    
    private func setupUI() {
        setupSearchBar()
        
        
        // MARK: - CollectionView Configuration
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = customBlackColor
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.minimumLineSpacing = 0
        
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = screenWidth / 3
        
        collectionViewLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        collectionView.collectionViewLayout = collectionViewLayout
        
    }
    
    private func setupSearchBar() {
        // UISearchBar nesnesini oluştur
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search friends..."
        
        searchBar.barTintColor = UIColor(named: "BackgroundColor")
        
        
        // SearchBar'ı view'e ekle
        view.addSubview(searchBar)
        
        // SearchBar'ın yerleşimini ayarla
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // CollectionView'un yerleşimini SearchBar'ın altına ayarla
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Burada arama metni değiştiğinde ne yapılacağını belirleyebilirsiniz
        // Örneğin, kullanıcı adlarını filtreleyebilir ve collectionView'ı güncelleyebilirsiniz
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(mockNames[indexPath.row])
    }
    
}
