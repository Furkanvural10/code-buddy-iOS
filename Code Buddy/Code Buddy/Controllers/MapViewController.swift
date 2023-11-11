//
//  MapViewController.swift
//  Code Buddy
//
//  Created by furkan vural on 10.11.2023.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var controlPanelView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var favImage: UIImageView!
    @IBOutlet weak var locationImage: UIImageView!
    
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        setupControlPanel()
        setupUI()
        
        
    }
    
    private func setupUI() {
        
        // MARK: - Add image clicked
        let gestureRecognizerForAddImage = UITapGestureRecognizer(target: self, action: #selector(openAddSheet(_:)))
        self.addImage.addGestureRecognizer(gestureRecognizerForAddImage)
        self.addImage.isUserInteractionEnabled = true
        
        // MARK: - Fav image clicked
        let gestureRecognizerForFavImage = UITapGestureRecognizer(target: self, action: #selector(openAddSheet(_:)))
        
        self.favImage.addGestureRecognizer(gestureRecognizerForFavImage)
        self.favImage.isUserInteractionEnabled = true
        
        // MARK: - location image clicked
        let gestureRecognizerForLocationImage = UITapGestureRecognizer(target: self, action: #selector(openAddSheet(_:)))
        self.locationImage.addGestureRecognizer(gestureRecognizerForLocationImage)
        self.locationImage.isUserInteractionEnabled = true
        
    }
    
    private func setupControlPanel() {
        self.controlPanelView.layer.cornerRadius = 15
        self.controlPanelView.backgroundColor = .black.withAlphaComponent(0.5)
        
        // Image Setup
        self.addImage.tintColor = .white
        self.favImage.tintColor = .red
        self.locationImage.tintColor = .systemBlue
    }
    
    
    private func setupMap() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.overrideUserInterfaceStyle = .dark
        mapView.showsUserLocation = true
        
    }
    
    
    @objc private func openAddSheet(_ sender: UITapGestureRecognizer) {
        guard let tappedImageView = sender.view as? UIImageView else { return }
        
        
        if tappedImageView == addImage {
            
            print("Tıklandı: add")
            
        } else if tappedImageView == favImage {
            
            print("Tıklandı: fav")
            
        } else {
            print("Tıklandı location")
        }
    }
    
}

extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location didudate worked")
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        
        self.mapView.setRegion(region, animated: true)
    }
    
}
