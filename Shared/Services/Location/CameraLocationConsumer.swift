//
//  LocationCamera.swift
//  carbonera (iOS)
//
//  Created by Yacine Alami on 09/02/2022.
//

import Foundation
import MapboxMaps

// Create class which conforms to LocationConsumer, update the camera's centerCoordinate when a locationUpdate is received
final class CameraLocationConsumer: LocationConsumer {
    weak var mapView: MapView?
    
    init() {}
    
    public func locationUpdate(newLocation: Location) {
        mapView?.camera.ease(
            to: CameraOptions(center: newLocation.coordinate, zoom: 10),
            duration: 1.3)
    }
}
