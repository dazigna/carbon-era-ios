//
//  carboneraApp.swift
//  Shared
//
//  Created by Yacine Alami on 13/01/2022.
//

import SwiftUI

@main
struct carboneraApp: App {
    init(){
//        NetworkManager().fetchItems().sink(onError: { err in
//            print(err)
//        }, receiveValue: { res in
//            print(res.data?.allItems?.count)
//        })
    }
    let viewModel = CarbonItemViewModel()
    
    var body: some Scene {
        WindowGroup{
            MainView()
        }
//        TabView{
//            CarbonItemListView(viewModel: viewModel)
//                .tabItem{
//                    Label("Items", systemImage: "")
//                }
//        }
    }
}
