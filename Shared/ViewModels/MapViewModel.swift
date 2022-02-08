//
//  MapViewModel.swift
//  carbonera
//
//  Created by Yacine Alami on 21/01/2022.
//

import Foundation
import CoreLocation
import MapKit

class MapViewModel: ObservableObject {
    
    var locationManager: LocationInterface
    
    init(locationManager: LocationInterface = LocationManager()){
        self.locationManager = locationManager
    }
    
}
