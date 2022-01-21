//
//  MainView.swift
//  carbonera
//
//  Created by Yacine Alami on 21/01/2022.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView{
            CarbonItemListView(viewModel: CarbonItemViewModel())
                .tabItem{
                    Label("Items", systemImage: "list.dash")
                }
            MapView()
                .tabItem{
                    Label("Map", systemImage: "map.circle")
                }
            UserView()
                .tabItem{
                    Label("User", systemImage: "person")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
