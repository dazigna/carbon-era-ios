//
//  ContentView.swift
//  Shared
//
//  Created by Yacine Alami on 13/01/2022.
//

import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var viewModel: StatsViewModel
    
    var body: some View {
        VStack{
            Text("Your current footprint")
                .font(.title)
            Text("\(viewModel.totalFootprint) \(UnitMass.kgCO2e.symbol)")
            List(viewModel.items, id: \.id) { it in
                Section(content: {
                    ForEach(it.items, id: \.id){ it2 in
                        HStack{
                            Text(it2.name)
                            Text(it2.measure.formattedWithBaseUnit() )
                        }
                    }
                }, header: {
                                HStack{
                                    Text(it.date.toString())
                                }
                    
                })
            }
            Button("Clear Data", action: {
                viewModel.clearData()
            })
        }
        .padding()
        .onAppear{
            print("on  appear stats")
            viewModel.load()
        }
            
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
