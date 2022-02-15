//
//  CarbonCategoryView.swift
//  carbonera
//
//  Created by Yacine Alami on 04/02/2022.
//

import SwiftUI

struct CarbonCategoryView: View{
    @Environment(\.isSearching) var isSearching
    @Environment(\.dismissSearch) var dismissSearch
    
    @EnvironmentObject var viewModel: CarbonItemViewModel
    @State private var showDetail: Bool = false
    
    var body: some View {
        VStack(alignment: .leading){
            List(viewModel.categories, id: \.id){ cat in
                CategoryRowView(category: cat)
                    .onTapGesture {
                        viewModel.selectedCategory = cat
                        showDetail = true
                    }
            }
            .emptyList(viewModel.categories){
                Text("Loading categories ...")
            }
            
            NavigationLink("", destination: CarbonSubCategoryView(), isActive: $showDetail)
        }
        .overlay{
            if isSearching && !viewModel.searchResults.isEmpty {
                CarbonItemsSearchResultsView()
                    .environmentObject(viewModel)
            }
        }
        .navigationTitle("Categories")
        .onAppear{
            self.viewModel.getParentCategories()
            self.viewModel.fetchUnits()
        }
    }
}

struct CarbonCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CarbonCategoryView()
    }
}
