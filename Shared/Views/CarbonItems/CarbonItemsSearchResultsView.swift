//
//  CarbonItemsSearch.swift
//  carbonera
//
//  Created by Yacine Alami on 07/02/2022.
//

import SwiftUI

struct CarbonItemsSearchResultsView: View {
    @EnvironmentObject var viewModel: CarbonItemViewModel
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        List(viewModel.searchResults, id: \.id) { item in
            CarbonItemRowView(carbonItem: item)
                .onTapGesture {
                    viewModel.selectedItem = item
                    viewRouter.showActionSheet = true
                }
                .emptyList(viewModel.searchResults){
                    Text("Searching items ...")
                }
                .partialSheet(isPresented: $viewRouter.showActionSheet){
                    CarbonItemDrawerView(isPresented: $viewRouter.showActionSheet)
                        .environmentObject(viewModel)
                }
        }
        .onDisappear{
            viewModel.cleanUpItems()
        }
    }
}

struct CarbonItemsSearch_Previews: PreviewProvider {
    static var previews: some View {
        CarbonItemsSearchResultsView()
    }
}
