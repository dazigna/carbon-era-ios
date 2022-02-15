//
//  SwiftUIView.swift
//  carbonera
//
//  Created by Yacine Alami on 08/02/2022.
//

import SwiftUI
import MapboxMaps


struct MapBoxView: UIViewRepresentable{
    // MARK: - Add viewmodel to provide all the info
    @EnvironmentObject var viewModel: MapViewModel
    
    func makeUIView(context: Context) -> MapView {
        let mapView = viewModel.createMapView()
        context.coordinator.mapView = mapView
        return mapView
    }
    
    func updateUIView(_ uiView: MapView, context: Context) {
        print("updateView")
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }


    final class Coordinator {
        private var cancelable: Cancelable?
        var mapView : MapView! {
            didSet{
                cancelable?.cancel()
                cancelable = nil
            }
        }

        init() {
        
        }
    }
}

struct MapBoxView_Previews: PreviewProvider {
    static var previews: some View {
        MapBoxView()
    }
}
