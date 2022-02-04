//
//  CarbonSubCategoryView.swift
//  carbonera
//
//  Created by Yacine Alami on 04/02/2022.
//

import SwiftUI

struct CarbonSubCategoryView: View {
    @EnvironmentObject var viewModel: CarbonItemViewModel
    @State private var showDetail: Bool = false

    var body: some View {
        
        VStack{
            List(viewModel.subCategories, id: \.id ){ cat in
                CategoryRowView(category: cat)
                    .onTapGesture {
                        viewModel.selectedSubCategory = cat
                        showDetail = true
                    }
                    .onAppear{
                        viewModel.checkIfCategoryFetchNeeded(cat: cat)
                    }
            }
            .emptyList(viewModel.subCategories){
                Text("Loading sub categories ...")
            }
            .navigationTitle(viewModel.selectedCategory?.name ?? "Sub-categories")
            .onAppear{
                viewModel.fetchCategoriesForParent()
            }
            .onDisappear{
                viewModel.cleanUpSubCategories()
            }
            NavigationLink("", destination: CarbonItemsView(), isActive: $showDetail)
                .isDetailLink(true)
        }
        
    }
}

struct CarbonSubCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CarbonSubCategoryView()
    }
}
