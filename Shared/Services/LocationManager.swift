//
//  LocationManager.swift
//  carbonera
//
//  Created by Yacine Alami on 08/02/2022.
//

import Foundation
import CoreLocation

protocol LocationInterface{
    var locationManager: CLLocationManager { get }
    func requestAuthorization()
    func requestLocation()
}

enum Regions{
    static let Paris: KeyValuePairs = ["latitude": 48.864716, "longitude": 2.349014]
}

class LocationManager: NSObject, CLLocationManagerDelegate, LocationInterface{

    var locationManager: CLLocationManager = CLLocationManager()
    var isAuthorized: Bool = false

    override init(){
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestAuthorization(){
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func requestLocation(){
        self.requestAuthorization()
        self.locationManager.requestLocation()
    }
    
    func stopLocation(){
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch (manager.authorizationStatus) {
        case .denied, .restricted:
            isAuthorized = false
        case .notDetermined:
            isAuthorized = false
        case .authorizedWhenInUse, .authorizedAlways:
            isAuthorized = true
            locationManager.startUpdatingLocation()
        @unknown default:
            fatalError()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.first{
//            self.userRegion = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }

}
