//
//  CarbonItemListView.swift
//  carbonera
//
//  Created by Yacine Alami on 20/01/2022.
//

import SwiftUI

struct CarbonView: View {
    @StateObject var viewModel: CarbonItemViewModel
    
    var body: some View {
        NavigationView {
            CategoryListView()
            .navigationTitle("Carbon items")
        }

        .environmentObject(viewModel)
    }
}

struct CategoryListView: View{
    @EnvironmentObject var viewModel: CarbonItemViewModel

    var body: some View {
        List(viewModel.categories, id: \.id){ cat in
            NavigationLink {
                SubCategoryListView(parentCategory: cat)
                    .onAppear{
                        viewModel.fetchCategoriesForParent(parentName: cat.name, first: 20)
                    }
            } label: {
                CategoryRowView(category: cat)
            }
        }
        .emptyList(viewModel.categories){
            Text("Loading categories ...")
        }
        .onAppear{
            self.viewModel.getParentCategories()
        }
    }
}

struct SubCategoryListView: View {
    @EnvironmentObject var viewModel: CarbonItemViewModel
    @State var parentCategory: Category
    
    var body: some View {
        List(viewModel.subCategories, id: \.id ){ cat in
            NavigationLink {
                CarbonItemListView(category: cat)
            } label: {
                CategoryRowView(category: cat)
                    .onAppear{
                        viewModel.checkIfCategoryFetchNeeded(cat: cat)
                    }
            }
        }
        .emptyList(viewModel.categories){
            Text("Loading categories ...")
        }
        .onDisappear{
            viewModel.cleanUpSubView()
        }
    }
}


struct CarbonItemListView: View{
    @EnvironmentObject var viewModel: CarbonItemViewModel
    
    @State var category: Category
    
    var body: some View {
        List(viewModel.items ?? []) { item in
            CarbonItemRowView(carbonItem: item)
        }
        .emptyList(viewModel.items ?? []){
            Text("Loading items ...")
        }
        .searchable(text: $viewModel.searchText)
        .onAppear{
            viewModel.getItemsForCategory(category: category)
        }
    }
}


struct CarbonItemListView_Previews: PreviewProvider {
    static var previews: some View {
        CarbonView(viewModel: CarbonItemViewModel())
    }
}
