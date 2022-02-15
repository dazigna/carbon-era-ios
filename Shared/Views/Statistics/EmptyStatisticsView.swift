//
//  EmptyStatisticsView.swift
//  carbonera (iOS)
//
//  Created by Yacine Alami on 15/02/2022.
//

import SwiftUI

struct EmptyStatisticsView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack{
            Text("No carbon footprint yet")
            Text("Start by adding an entry")
            Button("Add my first entry"){
                viewRouter.selectedTab = .items
            }
        }.padding()
        
    }
}

struct EmptyStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStatisticsView()
    }
}
