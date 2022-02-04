//
//  CarbonItemRowView.swift
//  carbonera
//
//  Created by Yacine Alami on 20/01/2022.
//

import SwiftUI

struct CarbonItemRowView: View {
    var carbonItem: Item
    
    var body: some View {
        HStack(spacing: 16){
            Text(carbonItem.name).truncationMode(.tail)
            Spacer()
            Text("\(carbonItem.totalPoste, specifier: "%.2f")")
            Text("\(carbonItem.unit.numerator)/\(carbonItem.unit.denominator)").font(.caption)
        }.padding()
    }
}

struct CarbonItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        CarbonItemRowView(carbonItem: Item.fake())
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
