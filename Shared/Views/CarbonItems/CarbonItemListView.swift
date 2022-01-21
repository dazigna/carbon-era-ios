//
//  CarbonItemListView.swift
//  carbonera
//
//  Created by Yacine Alami on 20/01/2022.
//

import SwiftUI

struct CarbonItemListView: View {
    @ObservedObject var viewModel: CarbonItemViewModel
    
    var body: some View {
        VStack{
            List(viewModel.items ?? []) { item in
                CarbonItemRowView(carbonItem: item)
            }
            .emptyList(viewModel.items ?? []){
                Text("Loading ...")
            }
            .onAppear{
                self.viewModel.fetchItems()
            }
        }
    }
 
}

struct CarbonItemListView_Previews: PreviewProvider {
    static var previews: some View {
        CarbonItemListView(viewModel: CarbonItemViewModel())
    }
}
