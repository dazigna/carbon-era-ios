//
//  CarbonItemListView.swift
//  carbonera
//
//  Created by Yacine Alami on 20/01/2022.
//

import SwiftUI
import PartialSheet

struct CarbonItemsView: View{
    @EnvironmentObject var viewModel: CarbonItemViewModel
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        List(viewModel.items, id: \.id) { item in
            CarbonItemRowView(carbonItem: item)
                .onTapGesture {
                    viewModel.selectedItem = item
                    viewRouter.showActionSheet = true
                }
                .onAppear{
                    viewModel.checkIfItemFetchNeeded(item: item)
                }
        }
        .emptyList(viewModel.items){
            Text("Loading items ...")
        }
        .partialSheet(isPresented: $viewRouter.showActionSheet){
            CarbonItemDrawerView(isPresented: $viewRouter.showActionSheet).environmentObject(viewModel)
        }
        .onAppear{
            viewModel.fetchItems()
        }
        .onDisappear{
            viewModel.cleanUpItems()
        }
        
        .navigationTitle(viewModel.selectedSubCategory?.name ?? "Sub-category")
    }
}


struct CarbonItemListView_Previews: PreviewProvider {
    static var previews: some View {
        CarbonItemsView()
    }
}
