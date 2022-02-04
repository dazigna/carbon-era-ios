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
                .foregroundColor(.accentColor)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(Color( UIColor.lightGray))
        }
    }
}

struct CategoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRowView(category: Category.fake())
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
