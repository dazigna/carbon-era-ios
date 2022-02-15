//
//  ContentView.swift
//  Shared
//
//  Created by Yacine Alami on 13/01/2022.
//

import SwiftUI

struct ContainerStatisticsView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var viewModel: StatsViewModel
    
    var body: some View {
        VStack{
            if(viewModel.items.isEmpty){
                EmptyStatisticsView()
            } else{
                StatisticsView()
            }
        }
        .onAppear{
            viewModel.load()
        }
    }
}

struct ContainerStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerStatisticsView()
    }
}
