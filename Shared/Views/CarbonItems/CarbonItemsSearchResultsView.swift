//
//  CarbonItemsSearch.swift
//  carbonera
//
//  Created by Yacine Alami on 07/02/2022.
//

import SwiftUI

struct CarbonItemsSearchResultsView: View {
    @EnvironmentObject var viewModel: CarbonItemViewModel
    @State private var isPresented = false
    
    var body: some View {
        List(viewModel.searchResults, id: \.id) { item in
            CarbonItemRowView(carbonItem: item)
                .onTapGesture {
                    viewModel.selectedItem = item
                    self.isPresented = true
                }
                .emptyList(viewModel.searchResults){
                    Text("Searching items ...")
                }
                .partialSheet(isPresented: $isPresented){
                    CarbonItemDrawerView(isPresented: $isPresented).environmentObject(viewModel)
                }
                .onDisappear{
                    viewModel.cleanUpItems()
                }
        }
        
    }
}

struct CarbonItemsSearch_Previews: PreviewProvider {
    static var previews: some View {
        CarbonItemsSearchResultsView()
    }
}
