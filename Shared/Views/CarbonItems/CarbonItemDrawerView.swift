//
//  CarbonItemDrawerView.swift
//  carbonera
//
//  Created by Yacine Alami on 01/02/2022.
//

import SwiftUI

struct CarbonItemDrawerView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: CarbonItemViewModel
    @State var item: Item
    @State private var sliderValue = 50.0
    @State private var textValue: Float = 0.0
    @State private var currentDate = Date()
    
    var body: some View {
        VStack{
            Spacer()
            Text(item.name ?? "Item name")
            Spacer()
            Slider(value: $sliderValue,
                   in: 0...100,
                   onEditingChanged: { boolEdit in
            })
            Spacer()
            TextField("Value", value: $textValue, format: .number).keyboardType(.decimalPad)
            Spacer()
            DatePicker("Date", selection: $currentDate, displayedComponents: [.date])
            Spacer()
            Button("Add", action: {
                viewModel.addItemToStore(item: item, value: textValue)
                dismiss()
            })
        }
    }
}

struct CarbonItemDrawerView_Previews: PreviewProvider {
    static var previews: some View {
        CarbonItemDrawerView(item: Item.fake())
            .previewLayout(.fixed(width: 300, height: 700))
    }
}
