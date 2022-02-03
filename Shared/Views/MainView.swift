//
//  MainView.swift
//  carbonera
//
//  Created by Yacine Alami on 21/01/2022.
//

import SwiftUI
import PartialSheet

struct MainView: View {
    var body: some View {
        TabView{
            CarbonView()
                .tabItem{
                    Label("Items", systemImage: "list.dash")
                }.environmentObject(CarbonItemViewModel())
            MapView(viewModel: MapViewModel())
                .tabItem{
                    Label("Map", systemImage: "map.circle")
                }
            StatisticsView(viewModel: StatsViewModel())
                .tabItem{
                    Label("Stats", systemImage: "sum")
                }
        }.addPartialSheet()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
