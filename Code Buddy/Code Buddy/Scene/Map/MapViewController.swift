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
        
        mapView.delegate = self
        mapView.register(MyCustomMapPinView.self, forAnnotationViewWithReuseIdentifier: "pin")
        mapView.register(MKClusterAnnotation.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        mapView.register(MyAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(MyClusterAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)

        
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
            
            SheetPresent.shared.sheetPresentView(vc: self, identifier: "showUserTableViewID", customHeight: nil)
            
        } else if tappedImageView == favImage {
            
            SheetPresent.shared.sheetPresentView(vc: self, identifier: "showPlacesID", customHeight: nil)
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    private lazy var imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(named: "fv")
        imageview.layer.cornerRadius = 8.0
//        imageview.backgroundColor = .orange
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
}

extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin", for: annotation)
//        pinView = MapPinView(annotation: annotation, reuseIdentifier: "pin")
//        return pinView
////        print("Worked-1")
//////        guard !(annotation is MKUserLocation) else { return nil }
////        print("Worked-2")
////        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "pin")
////        if annotationView == nil {
////            print("Worked-3")
////            annotationView = MapPinView(annotation: annotation, reuseIdentifier: "pin")
////        } else {annotationView?.annotation = annotation}
////
////        return annotationView
//    }
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? MKPointAnnotation else { return nil }
        
        let identifier = "customAnnotation"
        var annotationView: MKAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView = dequeuedView
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.calloutOffset = CGPoint(x: 25, y: -10)
            annotationView.canShowCallout = true
            
            let circleLayer = CALayer()
            circleLayer.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
            circleLayer.cornerRadius = 20 // Yarıçapı, genellikle boyutun yarısı olarak ayarlanır
            circleLayer.masksToBounds = true
            
            // Pin'in içine image ekleme
            let circleImage = UIImage(named: "fv") // Pin'in içine yerleştireceğiniz görüntü
            circleLayer.contents = circleImage?.cgImage
            let imageView = UIImageView(image: circleImage)
            imageView.frame = CGRect(x: 0, y: 0, width: 33, height: 33) // Ölçülerinizi belirleyin
            imageView.layer.cornerRadius = 20
            imageView.contentMode = .scaleAspectFit
//            annotationView.addSubview(imageView)
            annotationView.layer.addSublayer(circleLayer)

        }
        
        return annotationView
    
        
        
        
//        if annotation is MKUserLocation {
//            return nil
//        } else {
//            let identifier = "id"
//            var marker = MKMarkerAnnotationView()
//
//            if let dequeuedView = mapView.dequeueReusableAnnotationView(
//                withIdentifier: identifier) as? MKMarkerAnnotationView {
//                dequeuedView.annotation = annotation
//                marker = dequeuedView
//
//            } else {
//                marker.annotation = annotation
//            }
//
//            marker.canShowCallout = true
//            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
//
//            imageView.contentMode = .scaleAspectFit
//            imageView.image = UIImage(named: "fv")
//            imageView.contentMode = .scaleAspectFit
//
//            marker.glyphTintColor = .black
//            marker.glyphImage = UIImage(systemName: "person.fill")
//            marker.layer.cornerRadius = 60
//            marker.markerTintColor = .white
//
//            marker.leftCalloutAccessoryView = imageView
//            marker.leftCalloutAccessoryView?.layer.cornerRadius = 20
////            marker.clusteringIdentifier = "id"
//            return marker
//
//        }
    }
    
    
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let region = MKCoordinateRegion(center: location, span: span)
        self.location = location
        self.mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
    }
    
    
    func mapView(_ mapView: MKMapView, clusterAnnotationForMemberAnnotations memberAnnotations: [MKAnnotation]) -> MKClusterAnnotation {
        
        let cluster = MKClusterAnnotation(memberAnnotations: annotationList)
        cluster.title = "More things to see here"
        cluster.subtitle = "Zoom further in"
        return cluster
    }
}


class MyCustomMapPinView: MKAnnotationView {
    private lazy var containerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 110, height: 30))
        view.backgroundColor = .white
        view.layer.cornerRadius = 10.0
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(systemName: "person.circle")
        imageview.layer.cornerRadius = 8.0
//        imageview.backgroundColor = .orange
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    private lazy var bottomCornerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 3.0
        return view
    }()
    
    private lazy var titleLabelView: UILabel = {
        let titleLabelView = UILabel()
        titleLabelView.translatesAutoresizingMaskIntoConstraints = false
        titleLabelView.text = "Furkan Vural"
        titleLabelView.font = UIFont.systemFont(ofSize: 11)
        titleLabelView.adjustsFontSizeToFitWidth = true
        titleLabelView.textColor = .black
        return titleLabelView
    }()
    
    
    
    // MARK: Initialization
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        containerView.addSubview(bottomCornerView)
        bottomCornerView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15.0).isActive = true
        bottomCornerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        bottomCornerView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        bottomCornerView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        let angle = (39.0 * CGFloat.pi) / 180
        let transform = CGAffineTransform(rotationAngle: angle)
        bottomCornerView.transform = transform
        
        addSubview(containerView)
        containerView.addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0).isActive = true
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 2.0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -75.0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -2.0).isActive = true
        
        containerView.addSubview(titleLabelView)
        titleLabelView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 32).isActive = true
        titleLabelView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 5).isActive = true
        titleLabelView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        titleLabelView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 2).isActive = true
    
    }
}

class MyAnnotationView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? { didSet { update(for: annotation) } }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        configure(for: annotation)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configure()
    }
}

private extension MyAnnotationView {
    func configure(for annotation: MKAnnotation? = nil) {
        canShowCallout = true
        markerTintColor = .systemBlue
        rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        glyphImage = UIImage(named: "kenny")

        update(for: annotation)
    }

    func update(for annotation: MKAnnotation?) {
        clusteringIdentifier = "clusteringIdentifier"
        displayPriority = .required
    }
}


class MyClusterAnnotationView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? { didSet { update(for: annotation) } }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        update(for: annotation)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        update()
    }
}

private extension MyClusterAnnotationView {
    func update(for annotation: MKAnnotation? = nil) {
        markerTintColor = .systemGray
    }
}


extension MKMapView {
    var zoomLevel: Double {
        let maxZoom: Double = 20 // En büyük zoom seviyesi
        let region = self.region
        let span = region.span
        let longitudeDelta = span.longitudeDelta
        let mapWidthInPixels = Double(self.bounds.width)
        let zoomScale = longitudeDelta * 360.0 * (mapWidthInPixels / 256.0)
        let zoomExponent = log2(zoomScale)
        let zoom = max(0, min(zoomExponent, maxZoom))
        return zoom
    }
}
