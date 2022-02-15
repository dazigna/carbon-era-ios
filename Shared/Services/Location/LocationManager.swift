//
//  LocationManager.swift
//  carbonera
//
//  Created by Yacine Alami on 08/02/2022.
//

import Foundation
import CoreLocation
import MapboxMaps
import Combine

//protocol LocationInterface{
//    var locationManager: CLLocationManager { get }
//    func requestAuthorization()
//    func requestLocation()
//}

enum Regions{
    static let Paris: KeyValuePairs = ["latitude": 48.864716, "longitude": 2.349014]
}

class LocationManager: NSObject{
    @Published var location: CLLocation? = nil
    @Published var authorizationStatus: CLAuthorizationStatus
    
    private var locationManager: CLLocationManager = CLLocationManager()
    private var privateLocationProviderOptions: LocationOptions {
        didSet {
            locationManager.distanceFilter = privateLocationProviderOptions.distanceFilter
            locationManager.desiredAccuracy = privateLocationProviderOptions.desiredAccuracy
            locationManager.activityType = privateLocationProviderOptions.activityType
        }
    }
    // Location Provider delegate
    private weak var locationProviderDelegate: LocationProviderDelegate?
    
    override init(){
        self.privateLocationProviderOptions = LocationOptions()
        self.authorizationStatus = locationManager.authorizationStatus
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // One time location Request
    func requestLocation(){
        self.locationManager.requestLocation()
    }
}

// MARK: - Location Manager Delegate
extension LocationManager: CLLocationManagerDelegate{
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.locationProviderDelegate?.locationProviderDidChangeAuthorization(self)
        self.authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationProviderDelegate?.locationProvider(self, didUpdateLocations: locations)
        if let userLocation = locations.first{
            self.location = userLocation
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationProviderDelegate?.locationProvider(self, didFailWithError: error)
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.locationProviderDelegate?.locationProvider(self, didUpdateHeading: newHeading)
    }
}

// - MARK: Location Provider delegate
extension LocationManager: LocationProvider {
    var accuracyAuthorization: CLAccuracyAuthorization {
        return locationManager.accuracyAuthorization
    }
    
    var heading: CLHeading? {
        return locationManager.heading
    }
    
    public var headingOrientation: CLDeviceOrientation {
        set {
            locationManager.headingOrientation = newValue
        } get {
            return locationManager.headingOrientation
        }
    }
    
    public var locationProviderOptions: LocationOptions {
        get {
            return privateLocationProviderOptions
        }
        set {
            privateLocationProviderOptions = newValue
        }
    }
    
    func setDelegate(_ delegate: LocationProviderDelegate) {
        self.locationProviderDelegate = delegate
    }
    
    func requestAlwaysAuthorization() {
        self.locationManager.requestAlwaysAuthorization()
    }
    
    func requestWhenInUseAuthorization() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func requestTemporaryFullAccuracyAuthorization(withPurposeKey purposeKey: String) {
        self.locationManager.requestTemporaryFullAccuracyAuthorization(withPurposeKey: purposeKey)
    }
    
    func startUpdatingLocation() {
        self.locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        self.locationManager.stopUpdatingLocation()
    }
    
    func startUpdatingHeading() {
        self.locationManager.startUpdatingHeading()
    }
    
    func stopUpdatingHeading() {
        self.locationManager.stopUpdatingHeading()
    }
    
    func dismissHeadingCalibrationDisplay() {
        self.locationManager.dismissHeadingCalibrationDisplay()
    }
}
