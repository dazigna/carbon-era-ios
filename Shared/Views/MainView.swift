//
//  MainView.swift
//  carbonera
//
//  Created by Yacine Alami on 21/01/2022.
//

import SwiftUI

struct MainView: View {
    @StateObject var mapViewModel = MapViewModel()
    
    var body: some View {
        TabView{
            CarbonView(viewModel: CarbonItemViewModel())
                .tabItem{
                    Label("Items", systemImage: "list.dash")
                }
//                .environmentObject(carbonViewModel)
            MapView(viewModel: MapViewModel())
                .tabItem{
                    Label("Map", systemImage: "map.circle")
                }
//                .environmentObject(mapViewModel)
//            UserView()
//                .tabItem{
//                    Label("User", systemImage: "person")
//                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
