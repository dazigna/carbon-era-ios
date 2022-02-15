//
//  MainView.swift
//  carbonera
//
//  Created by Yacine Alami on 21/01/2022.
//

import SwiftUI
import PartialSheet

struct MainView: View {
    @EnvironmentObject var carbonViewModel: CarbonItemViewModel
    @EnvironmentObject var mapViewModel: MapViewModel
    @EnvironmentObject var statsViewModel: StatsViewModel
    var body: some View {
        TabView{
            CarbonView()
                .tabItem{
                    Label("Items", systemImage: "list.dash")
                }
                .environmentObject(carbonViewModel)
            CarbonMapView()
                .tabItem{
                    Label("Map", systemImage: "map.circle")
                }
                .environmentObject(mapViewModel)
            StatisticsView()
                .tabItem{
                    Label("Stats", systemImage: "sum")
                }
                .environmentObject(statsViewModel)
        }.addPartialSheet()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
