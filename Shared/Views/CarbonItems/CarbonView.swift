//
//  CarbonView.swift
//  carbonera
//
//  Created by Yacine Alami on 04/02/2022.
//

import SwiftUI

struct CarbonView: View {
    @EnvironmentObject var viewModel: CarbonItemViewModel
    
    var body: some View {
        NavigationView{
            CarbonCategoryView()
        }
        .navigationViewStyle(.stack)
    }
}

struct CarbonView_Previews: PreviewProvider {
    static var previews: some View {
        CarbonView()
    }
}
