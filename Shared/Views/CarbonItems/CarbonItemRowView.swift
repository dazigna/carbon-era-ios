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
        HStack{
            Text(carbonItem.name!)
            Spacer()
            Text("\(carbonItem.totalPoste!)")
            Spacer()
            Text(carbonItem.unitStr!)
        }
    }
}

struct CarbonItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        CarbonItemRowView(carbonItem: Item.fake())
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
