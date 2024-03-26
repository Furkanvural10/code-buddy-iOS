//
//  Location.swift
//  Code Buddy
//
//  Created by furkan vural on 25.03.2024.
//

import Foundation
import CoreLocation

final class LocationProvider: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationProvider()
    private let locationManager = CLLocationManager()
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManagerDidChangeAuthorization(locationManager)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            latitude = manager.location!.coordinate.latitude
            longitude = manager.location!.coordinate.longitude
            default:
            latitude = 0.0
            longitude = 0.0
        }
    }
}

