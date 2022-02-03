//
//  ContentView.swift
//  Shared
//
//  Created by Yacine Alami on 13/01/2022.
//

import SwiftUI

struct StatisticsView: View {
    @StateObject var viewModel: StatsViewModel
    
    var body: some View {
        VStack{
            Text("Your current footprint")
                .font(.title)
            Text("\(viewModel.totalFootprint) \(UnitMass.kgCO2e.symbol)")
            
            Button("Clear Data", action: {
                viewModel.clearData()
            })
        }.padding()
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView(viewModel: StatsViewModel())
    }
}
