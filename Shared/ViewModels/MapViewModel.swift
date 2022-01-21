//
//  MapViewModel.swift
//  carbonera
//
//  Created by Yacine Alami on 21/01/2022.
//

import Foundation
import CoreLocation
import MapKit

protocol MapViewInterface{
    func requestAuthorization()
    func requestLocation()
}

class MapViewModel: NSObject, ObservableObject, MapViewInterface, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager
    
    // Paris
    @Published var userRegion: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 48.864716,
            longitude: 2.349014
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 1,
            longitudeDelta: 1
        )
    )
    @Published var isAuthorized: Bool = false
    
    init(locationManager: CLLocationManager = CLLocationManager()){
        self.locationManager = locationManager
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
            self.userRegion = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
