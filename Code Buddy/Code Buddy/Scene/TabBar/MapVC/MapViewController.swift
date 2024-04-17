//
//  MapViewController.swift
//  Code Buddy
//
//  Created by furkan vural on 10.11.2023.
//

import UIKit
import MapKit
import CoreLocation
import AudioToolbox
import FirebaseAuth

final class MapViewController: UIViewController {
    
    @IBOutlet private weak var mapView: MKMapView!
    private var shakeImage: UIImageView!
    private var loadingView: UIActivityIndicatorView!

    private var tabBarCounter = [Int](repeating: 0, count: 4)
    private let viewModel = MapViewModel()
    
    private lazy var locationManager = CLLocationManager()
    private var location: CLLocationCoordinate2D!
    private var userID: String = Auth.auth().currentUser!.uid
    private var allUser = [User]()
    
    // Mock Location Data
    let locations = [
        CLLocationCoordinate2D(latitude: 41.0791, longitude: 29.0314),
        CLLocationCoordinate2D(latitude: 41.0807, longitude: 29.0344),
        CLLocationCoordinate2D(latitude: 41.0844, longitude: 29.0325),
        CLLocationCoordinate2D(latitude: 41.0844, longitude: 29.0325),
        CLLocationCoordinate2D(latitude: 41.0508, longitude: 29.0248),
        CLLocationCoordinate2D(latitude: 41.050867721024225, longitude: 29.032714963905693),
        CLLocationCoordinate2D(latitude: 41.051320810029004, longitude: 29.02232945069483),
        CLLocationCoordinate2D(latitude: 41.04209659766404, longitude: 29.009583593572426),
        CLLocationCoordinate2D(latitude: 41.04297052575788, longitude: 29.010828138554153),
    ]
    var annotationList = [MKAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingView()
        getUser()
        viewModel.delegate = self
        setupTabBar()
        setupMap()
        
        
    }
    
    private func setupLoadingView() {
        loadingView = UIActivityIndicatorView(style: .large)
        view.addBlurView()
        loadingView.color = .white
        
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupTabBar() {
        self.tabBarController?.delegate = self
    }
    
    private func setupMap() {
        
        mapView.delegate = self
        mapView.register(MKClusterAnnotation.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        DispatchQueue.main.async {
            self.mapView.overrideUserInterfaceStyle = .dark
        }
    
    }
    
    func showUser(allUsers: [User]) {
        
        DispatchQueue.main.async {
            self.mapView.showsUserLocation = true
            allUsers.forEach { user in
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: user.location.latitude, longitude: user.location.longitude)
                self.annotationList.append(annotation)
                annotation.title = user.name
                annotation.subtitle = user.title
                self.mapView.addAnnotation(annotation)
            }
            self.loadingView.stopAnimating()
            self.view.removeBlurViewFromView()
        }
        
    }
    
    private func getUser() {
        DispatchQueue.main.async {
            self.loadingView.startAnimating()
        }
        self.viewModel.getUsers()
        self.allUser = self.viewModel.users
    }
}

extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? MKPointAnnotation else { return nil }
        
        let identifier = "customAnnotation"
        var annotationView: MKAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView = dequeuedView
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.calloutOffset = CGPoint(x: 0, y: -14)
            annotationView.canShowCallout = true
            
            // MARK: - Circle of Annotation Layer
            let circleLayer = CALayer()
            circleLayer.bounds = CGRect(x: 0, y: 0, width: 37, height: 37)
            circleLayer.cornerRadius = 20
            circleLayer.borderWidth = 1.5
            circleLayer.borderColor = UIColor.systemBlue.cgColor
            circleLayer.masksToBounds = true
            
            let circleImage = UIImage(named: "fv")
            circleLayer.contents = circleImage?.cgImage
            
            let imageView = UIImageView(image: circleImage)
            imageView.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
            imageView.layer.cornerRadius = imageView.frame.size.height / 2
            imageView.contentMode = .scaleAspectFit
            imageView.layer.borderWidth = 10
            imageView.layer.borderColor = UIColor.white.cgColor

            annotationView.layer.addSublayer(circleLayer)
            
            // Right Callout Accessory View (Button)
            shakeImage = UIImageView()
            shakeImage.isUserInteractionEnabled = true
            shakeImage.image = UIImage(named: "shakeHand")
            shakeImage.frame = CGRectMake(0,0,50,50)
            annotationView.rightCalloutAccessoryView = shakeImage
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handShakeClicked))
            shakeImage.addGestureRecognizer(tapGestureRecognizer)
        }
        return annotationView
    }
        
    @objc private func handShakeClicked() {
        
        self.makeBackgroundBlur()
        self.showWaveMessage()
    }
    
    // Stay
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = CLLocationCoordinate2D(
            latitude: locations[0].coordinate.latitude,
            longitude: locations[0].coordinate.longitude
        )
        
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let region = MKCoordinateRegion(center: location, span: span)
        self.location = location
        self.mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
    }
    
    private func makeBackgroundBlur() {
        DispatchQueue.main.async { self.view.addBlurView() }
        showAlertController(title: "XX", message: "YY", preferredStyle: .actionSheet)
    }
    
    @objc private func showWaveMessage() {
        DispatchQueue.main.async {
            self.view.removeBlurViewFromView()
        }
        
    }
    
    private func showAlertController(title: String, message: String, preferredStyle: UIAlertController.Style) {
        let alertController = UIAlertController(title: title,  message: message, preferredStyle: preferredStyle)
        let sayHiButton = UIAlertAction(title: "Hi 👋", style: .default) { _ in
            AudioServicesPlaySystemSoundWithCompletion(1519) { }
            self.checkUserProfil()
            
        }
        let sayHaveNiceDayButton = UIAlertAction(title: "Have a nice day 😊", style: .default) { _ in
            AudioServicesPlaySystemSoundWithCompletion(1519) { }
        }
        
        
        let workTogetherButton = UIAlertAction(title: "Work Together 🤝", style: .default) { _ in
            AudioServicesPlaySystemSoundWithCompletion(1519) { }
        }
        
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        cancel.setValue(UIColor.systemRed, forKeyPath: "titleTextColor")

        alertController.addAction(sayHiButton)
        alertController.addAction(cancel)
        alertController.addAction(sayHaveNiceDayButton)
        alertController.addAction(workTogetherButton)
        self.present(alertController, animated: true)
    }
    
    private func checkUserProfil() {
        viewModel.checkUserProfileCrated(receiverID: "Tıklanan kullanıcının ID'si")
    }
    
    private func showSheetMessage(title: String, message: String, color: UIColor, iconName: String) {
        let sheetPresentationController = self.storyboard?.instantiateViewController(withIdentifier: "MessageSheetViewController") as! MessageSheetViewController
        sheetPresentationController.configure(title: title, message: message, color: color, iconName: iconName)
        self.present(sheetPresentationController, animated: true)
    }
    
    
}

extension MapViewController: UITabBarControllerDelegate {
    
    // MOVE VM
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        let selectedIndex = tabBarController.selectedIndex
        tabBarCounter[selectedIndex] += 1
        
        if tabBarCounter[selectedIndex] >= 2 && tabBarController.selectedIndex == 0 {
            locationManager.startUpdatingLocation()
            tabBarCounter[selectedIndex] = 0
            locationManager.stopUpdatingLocation()
        }
    }
}

extension MapViewController: MapViewControllerDelegate {

    func showErrorAlertMessage(title: String, message: String) {
        showSheetMessage(title: title, message: message, color: .systemRed, iconName: "car")
    }
    
    func showSuccessAlertMessage(title: String, message: String) {
        showSheetMessage(title: title, message: message, color: .systemGreen, iconName: "car")
    }

}
