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
        NavigationView{
            CategoryListView()
                .background(NavigationLink(destination: EmptyView()) {})
                .background(NavigationLink(destination: EmptyView()) {})

        }
        .navigationViewStyle(.stack)
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
                        viewModel.fetchCategoriesForParent(parentName: cat.name)
                    }
            } label: {
                CategoryRowView(category: cat)
            }
            .isDetailLink(false)
        }
        .emptyList(viewModel.categories){
            Text("Loading categories ...")
        }
        .navigationTitle("Categories")
        .onAppear{
            print("on Appear")
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
                    .onAppear{
                        print("On Appear items ")
                        viewModel.fetchItems(forCategory: cat)
                    }
            } label: {
                CategoryRowView(category: cat)
                    .onAppear{
                        viewModel.checkIfCategoryFetchNeeded(cat: cat)
                    }
            }
            .isDetailLink(false)
        }
        .emptyList(viewModel.categories){
            Text("Loading categories ...")
        }
        .navigationTitle(parentCategory.name)
        .onDisappear{
            print("DISAPPEAR")
            viewModel.cleanUpSubCategories()
        }
    }
}


struct CarbonItemListView: View{
    @EnvironmentObject var viewModel: CarbonItemViewModel
    
    @State var category: Category
    @State private var isPresented = false
    @State private var selectedItem: Item? = nil
    var body: some View {
        List(viewModel.items, id: \.id) { item in
            CarbonItemRowView(carbonItem: item).onTapGesture {
                selectedItem = item
            }
        }
        .emptyList(viewModel.items){
            Text("Loading items ...")
        }
        .sheet(item: $selectedItem, onDismiss: {
            selectedItem = nil
        }, content: { item in
            CarbonItemDrawerView(item: item)
        })
//        .searchable(text: $viewModel.searchText)
        .onDisappear{
            print("DISAPPEAR ITEMS")
            viewModel.cleanUpItems()
        }
        .navigationTitle(category.name)
    }
}


struct CarbonItemListView_Previews: PreviewProvider {
    static var previews: some View {
        CarbonView(viewModel: CarbonItemViewModel())
    }
}
