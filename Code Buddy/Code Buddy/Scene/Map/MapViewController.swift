//
//  MapViewController.swift
//  Code Buddy
//
//  Created by furkan vural on 10.11.2023.
//

import UIKit
import MapKit
import CoreLocation

final class MapViewController: UIViewController {
    
    @IBOutlet private weak var controlPanelView: UIView!
    @IBOutlet private weak var mapView: MKMapView!
    
    @IBOutlet private weak var addImage: UIImageView!
    @IBOutlet private weak var favImage: UIImageView!
    @IBOutlet private weak var locationImage: UIImageView!
    @IBOutlet private weak var personsImage: UIImageView!
    
    private lazy var locationManager = CLLocationManager()
    private var location: CLLocationCoordinate2D!
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
                // ... Daha fazla konum eklenebilir
            ]
    var annotationList = [MKAnnotation]()
    
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
        
        // MARK: - Users image clicked
        let gestureRecognizerForUsersImage = UITapGestureRecognizer(target: self, action: #selector(openAddSheet(_:)))
        self.personsImage.addGestureRecognizer(gestureRecognizerForUsersImage)
        self.personsImage.isUserInteractionEnabled = true
        
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
        self.personsImage.tintColor = .systemGreen
        self.locationImage.tintColor = .systemBlue
    }
    
    
    private func setupMap() {
        mapView.delegate = self
        mapView.register(MKClusterAnnotation.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.overrideUserInterfaceStyle = .dark
        mapView.showsUserLocation = true
        
        
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotationList.append(annotation)
            annotation.title = "Furkan Vural\nWorking"
            annotation.subtitle = "iOS Developer"
            
            mapView.addAnnotation(annotation)
        }

    }
    
    @objc private func openAddSheet(_ sender: UITapGestureRecognizer) {
        guard let tappedImageView = sender.view as? UIImageView else { return }
        
        if tappedImageView == addImage {
            let customSheetHeight = view.bounds.height * 0.35
            SheetPresent.shared.sheetPresentView(vc: self, identifier: "addAnnotationIdentifier", customHeight: customSheetHeight)
            
        } else if tappedImageView == personsImage {
            SheetPresent.shared.sheetPresentView(vc: self, identifier: "showUsersID", customHeight: nil)
            
        } else if tappedImageView == favImage {
            SheetPresent.shared.sheetPresentView(vc: self, identifier: "showPlacesID", customHeight: nil)
        } else {
            locationManager.startUpdatingLocation()
        }
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
            circleLayer.bounds = CGRect(x: 0, y: 0, width: 38, height: 38)
            circleLayer.cornerRadius = 20
            circleLayer.masksToBounds = true
            
            // MARK: - Circle of Status Layer
            let statusCircle = CALayer()
            statusCircle.bounds = CGRect(x: 0, y: 0, width: 9, height: 9)
            statusCircle.cornerRadius = 5
            statusCircle.masksToBounds = true
            
            // Status Circle Position in the annotation
            let circleOffset = CGPoint(x: -17.5, y: -20)
            statusCircle.position = CGPoint(x: circleOffset.x + 5, y: circleOffset.y + 5)
            
            // status Color Check (If user busy, red, else green)
            let isActive = false //
            statusCircle.backgroundColor = isActive ? UIColor.systemGreen.cgColor : UIColor.systemRed.cgColor
            
            
            // Pin'in içine image ekleme (Kullanıcının app'e yüklediği image olacak)
            let circleImage = UIImage(named: "fv")
            circleLayer.contents = circleImage?.cgImage
            
            // imageView in the annotations
            let imageView = UIImageView(image: circleImage)
            imageView.frame = CGRect(x: 0, y: 0, width: 33, height: 33)
            imageView.layer.cornerRadius = 15
            imageView.contentMode = .scaleAspectFit
            
            // Adding sublayer to annotationView
            annotationView.layer.addSublayer(circleLayer)
            annotationView.layer.addSublayer(statusCircle)


        }
        return annotationView
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let region = MKCoordinateRegion(center: location, span: span)
        self.location = location
        self.mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
    }
    
    // For ClusterAnnotation
//    func mapView(_ mapView: MKMapView, clusterAnnotationForMemberAnnotations memberAnnotations: [MKAnnotation]) -> MKClusterAnnotation {
//
//        let cluster = MKClusterAnnotation(memberAnnotations: annotationList)
//        cluster.title = "More things to see here"
//        cluster.subtitle = "Zoom further in"
//        return cluster
//    }
}

