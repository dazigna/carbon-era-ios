//
//  carboneraApp.swift
//  Shared
//
//  Created by Yacine Alami on 13/01/2022.
//

import SwiftUI
import PartialSheet
@main
struct carboneraApp: App {
    var carbonViewModel: CarbonItemViewModel
    var mapViewModel: MapViewModel
    var statsViewModel: StatsViewModel
    var carbonStore: StorageInterface
    
    init(){
        self.carbonStore = CarbonStore()
        self.carbonViewModel = CarbonItemViewModel(store: self.carbonStore)
        self.mapViewModel = MapViewModel(store: self.carbonStore)
        self.statsViewModel = StatsViewModel(store: self.carbonStore)
        
        LocationManager().requestLocation()
    }
        
    var body: some Scene {
        WindowGroup{
            MainView()
                .environmentObject(carbonViewModel)
                .environmentObject(mapViewModel)
                .environmentObject(statsViewModel)
                .environmentObject(PartialSheetManager())

        }
    }
}
