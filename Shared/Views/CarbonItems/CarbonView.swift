//
//  CarbonView.swift
//  carbonera
//
//  Created by Yacine Alami on 04/02/2022.
//

import SwiftUI
import Combine

struct CarbonView: View {

    @EnvironmentObject var viewModel: CarbonItemViewModel
    
    var body: some View {
        NavigationView{
            CarbonCategoryView()
        }
        .searchable(text: $viewModel.searchText, prompt:"Search items"){
            ForEach(viewModel.suggestedResults) { suggestion in
                    //TODO: Fix the display of multiple results
                Text(suggestion.name).foregroundColor(.blue)
                        .searchCompletion(suggestion.name)
                }
        }
        .onReceive(viewModel.$searchText.debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
        ){
            guard !$0.isEmpty else { return }
            print("SEARCH")
            viewModel.searchItems()
        }
        .onSubmit(of: .search) {
            print("SUBMIT")
            viewModel.getSingleItem()
        }
        .navigationViewStyle(.stack)
    }
}

struct CarbonView_Previews: PreviewProvider {
    static var previews: some View {
        CarbonView()
    }
}
