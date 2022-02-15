//
//  UserDefaultsExtensions.swift
//  carbonera (iOS)
//
//  Created by Yacine Alami on 09/02/2022.
//

import Foundation
import CoreLocation

extension UserDefaults {
    func set(_ location: CLLocation, forKey key: String){
        let locLatitude =  location.coordinate.latitude
        let locLongitude = location.coordinate.longitude
        self.set(["latitude": locLatitude, "longitude": locLongitude], forKey:key)
    }
    
    func location(forKey key: String) -> CLLocation?
    {
        guard let locationDict = self.object(forKey: key) as? Dictionary<String, CLLocationDegrees>,
              let latitude = locationDict["latitude"],
              let longitude = locationDict["longitude"]
        else { return nil }

        return CLLocation(latitude: latitude, longitude: longitude)
    }
}
