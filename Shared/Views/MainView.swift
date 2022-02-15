//
//  MainView.swift
//  carbonera
//
//  Created by Yacine Alami on 21/01/2022.
//

import SwiftUI
import PartialSheet

struct MainView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var carbonViewModel: CarbonItemViewModel
    @EnvironmentObject var mapViewModel: MapViewModel
    @EnvironmentObject var statsViewModel: StatsViewModel
    
    var body: some View {
        TabView(selection: $viewRouter.selectedTab){
            ContainerStatisticsView()
                .tabItem{
                    Label("Stats", systemImage: "sum")
                }
                .tag(Tabs.stats)
                .environmentObject(statsViewModel)
            CarbonView()
                .tabItem{
                    Label("Items", systemImage: "list.dash")
                }
                .tag(Tabs.items)
                .environmentObject(carbonViewModel)
            CarbonMapView()
                .tabItem{
                    Label("Map", systemImage: "map.circle")
                }
                .tag(Tabs.map)
                .environmentObject(mapViewModel)
        }.addPartialSheet()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
