//
//  MapView.swift
//  carbonera
//
//  Created by Yacine Alami on 21/01/2022.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct MapView: View {
    
    @ObservedObject var viewModel: MapViewModel

    @State private var trackingMode = MapUserTrackingMode.follow

    var body: some View {
        ZStack(alignment: .bottom){
            Map(
                coordinateRegion: $viewModel.userRegion,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: $trackingMode
            )
            
            HStack{
                Spacer()
                LocationButton(.currentLocation){
                    viewModel.requestLocation()
                }
                .labelStyle(.iconOnly)
                .symbolVariant(.fill)
                .tint(.blue)
            }
            .padding()
        }.onAppear{
            viewModel.requestAuthorization()
        }
        .padding()
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(viewModel: MapViewModel())
    }
}
