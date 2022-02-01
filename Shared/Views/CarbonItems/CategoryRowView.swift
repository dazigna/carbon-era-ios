//
//  CategoryRowView.swift
//  carbonera
//
//  Created by Yacine Alami on 24/01/2022.
//

import SwiftUI

struct CategoryRowView: View {
    
    var category: Category

    var body: some View {
        HStack {
            Text(category.name)
        }
    }
}

struct CategoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRowView(category: Category(parent: "parent", name: "Category", cursor: ""))
            .previewLayout(.fixed(width: 300, height: 70))
    }
}