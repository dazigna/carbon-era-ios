//
//  MapViewModel.swift
//  carbonera
//
//  Created by Yacine Alami on 21/01/2022.
//

import Foundation
import CoreLocation
import Combine
import MapboxMaps

//https://github.com/mapbox/mapbox-maps-ios/blob/main/Apps/Examples/Examples/All%20Examples/SwiftUIExample.swift

struct Camera {
    var center: CLLocationCoordinate2D
    var zoom: CGFloat
}

class MapViewModel: ObservableObject {
    
    private var subscriptions = Set<AnyCancellable>()
    private var locationManager: LocationManager
    private var currentLocation: CLLocation? = nil
    private var store: StorageInterface
    private let cameraLocationConsumer = CameraLocationConsumer()
    
    //MapBox objects
    private var mapBoxToken: String
    private let dataSourceIdentifier = "carbon-source"
    private let heatMapIdentifier = "carbon-heatmap"
    init(locationManager: LocationManager = LocationManager(), store: StorageInterface){
        guard let token = Bundle.main.mapBoxToken else {
            fatalError("Missing mapbox token")
        }
        self.mapBoxToken = token
        self.locationManager = locationManager
        self.store = store
        
        self.locationManager.$location.sink(receiveValue: { userLocation in
            print("RECEIVED LOCATION \(String(describing: userLocation))")
            guard let location = userLocation else { return }
            
            UserDefaults.standard.set(location, forKey: "userLocation")
            
            self.currentLocation = location
        }).store(in: &subscriptions)
                
        updateUserLocation()
    }
    
    func updateUserLocation(){
        self.locationManager.requestLocation()
    }
    
    func createGeoJSONFromStore() -> GeoJSONSource{
        let totalFootprint = store.content.map({$0.measure.value}).reduce(0, +)
        let userLocation = UserDefaults.standard.location(forKey: "userLocation")!

        var f = Feature(geometry: Geometry.point(Point(LocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude))))
        f.properties = JSONObject(rawValue: ["footprint": totalFootprint])
        
        var source = GeoJSONSource()
        source.data = GeoJSONSourceData.feature(f)
        return source
    }
    
    func createDemoSource() -> GeoJSONSource{
        var source = GeoJSONSource()
        var featureCollection: [Feature] = []
        for _ in 0...100{
            let latitude = CLLocationDegrees(Float.random(in: -0.15 ..< 0.13))
            let longitude = CLLocationDegrees(Float.random(in: 51.45 ..< 51.55))
            let footprint = Float.random(in: 8000 ..< 15000)
            
            var f = Feature(geometry: Geometry.point(Point(LocationCoordinate2D(latitude: longitude, longitude: latitude))))
            f.properties = JSONObject(rawValue: ["footprint": footprint])
            
            featureCollection.append(f)
        }
        let collec = FeatureCollection(features: featureCollection)
        source.data = GeoJSONSourceData.featureCollection(collec)
        return source
    }
    
    
    func configureMapInit() ->  MapInitOptions{
        let resourceOptions = ResourceOptions(accessToken: mapBoxToken)
        var cameraOptions: CameraOptions? = nil
        
        if let userLocation = self.currentLocation {
            cameraOptions = CameraOptions(center: userLocation.coordinate, zoom: 10)
        }
        
        return MapInitOptions(resourceOptions: resourceOptions, cameraOptions: cameraOptions)
    }
    
    func createMapView() -> MapView {

        let mapView = MapView(frame: .zero, mapInitOptions: configureMapInit())
        
        //Setup custom location provider
        mapView.location.overrideLocationProvider(with: self.locationManager)
        
        //Setup user's camera puck
        mapView.location.options.puckType = .puck2D()
        mapView.location.options.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        mapView.location.options.puckBearingSource = .heading
        mapView.location.options.activityType = .other

        self.cameraLocationConsumer.mapView = mapView
        
        //After map is loaded
        mapView.mapboxMap.onNext(.mapLoaded) { _ in
            // Register the location consumer with the map
            // Note that the location manager holds weak references to consumers, which should be retained
            mapView.location.addLocationConsumer(newConsumer: self.cameraLocationConsumer)
            
            // Add the GeoJSON source to the style
            let source = self.createDemoSource()
            try! mapView.mapboxMap.style.addSource(source, id: self.dataSourceIdentifier)
            // Add the heatmap layer to the map.
            let layer = self.createHeatMap()
            try! mapView.mapboxMap.style.addLayer(layer)
            
            //Add circle Layer
            let circleLayer = self.createCircleLayer()
            try! mapView.mapboxMap.style.addLayer(circleLayer)

        }
        return mapView
    }
    
    //TODO: Use carbon store instead of url
    func createMapSource() -> GeoJSONSource{
        let url = URL(string: "https://www.mapbox.com/mapbox-gl-js/assets/earthquakes.geojson")!
        
        // Create a GeoJSON data source.
        var geoJSONSource = GeoJSONSource()
        geoJSONSource.data = GeoJSONSourceData.url(url)
        return geoJSONSource
    }
    
    func createCircleLayer() -> CircleLayer {
        var footprintLayer = CircleLayer(id: "individualFootprint")
        footprintLayer.source = dataSourceIdentifier
        footprintLayer.sourceLayer = heatMapIdentifier

        let stops: [Double: Double] = [
          // If the map is at zoom level 12 or below,
          // set circle radius to 2
          12: 2.0,
          // If the map is at zoom level 22 or above,
          // set circle radius to 180
          22: 180.0
        ]

        // Produce a continuous, smooth series of values
        // between pairs of input and output values
        let zoomExp = Exp(.interpolate) {
          // Set the interpolation type
          Exp(.exponential) { 1.75 }
          // Get current zoom level
          Exp(.zoom)
          // Use the stops defined above
          stops
        }

        let stopsOpacity: [Double: Double] = [
          // If the map is at zoom level 12 or below,
          // set circle radius to 2
            0: 0,
          // If the map is at zoom level 22 or above,
          // set circle radius to 180
            9: 0.75
        ]
        
        footprintLayer.circleOpacity = .expression(
            Exp(.zoom){
                stops
            })
               
        footprintLayer.circleRadius = .expression(zoomExp)
        footprintLayer.circleOpacity = .constant(0.3)
        footprintLayer.circleColor = .constant(StyleColor(UIColor.cyan))
        return footprintLayer
    }
    
    func createHeatMap() -> HeatmapLayer{
        // Create the heatmap layer using the specified layer and source IDs.
        var layer = HeatmapLayer(id: heatMapIdentifier)
        layer.source = dataSourceIdentifier
        layer.heatmapWeight = .expression(
            Exp(.interpolate){
                Exp(.linear)
                Exp(.get){
                    "footprint"
                }
                0
                2
                4
                1
            }
        )
        // Set the heatmap layer's color property.
        layer.heatmapColor = .expression(
            Exp(.interpolate) {
                Exp(.linear)
                Exp(.heatmapDensity)
                0
                UIColor.clear
                0.2
                UIColor.gray
                0.4
                UIColor.green
                0.6
                UIColor.orange
                1.0
                UIColor.red
        })
        
        let stops: [Double: Double] = [
          // If the map is at zoom level 12 or below,
          // set circle radius to 2
            0: 0,
          // If the map is at zoom level 22 or above,
          // set circle radius to 180
           2: 1
        ]

        layer.heatmapOpacity = .expression( Exp(.interpolate) {
          // Set the interpolation type
          Exp(.exponential) { 1.75 }
          // Get current zoom level
          Exp(.zoom)
          // Use the stops defined above
          stops
        })
        return layer
    }
    
}
