//
//  MapView.swift
//  carbonera
//
//  Created by Yacine Alami on 21/01/2022.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct CarbonMapView: View {
    @EnvironmentObject var viewModel: MapViewModel
    
    var body: some View {
        MapBoxView()
    }
}

struct CarbonMapView_Previews: PreviewProvider {
    static var previews: some View {
        CarbonMapView()
    }
}
