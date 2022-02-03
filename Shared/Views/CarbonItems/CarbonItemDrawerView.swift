//
//  CarbonItemDrawerView.swift
//  carbonera
//
//  Created by Yacine Alami on 01/02/2022.
//

import SwiftUI

struct CarbonItemDrawerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isPresented: Bool
    @EnvironmentObject var viewModel: CarbonItemViewModel
    @State private var textValue: Double = 0.0
    @State private var currentDate = Date()
    
    var body: some View {
        VStack(alignment:.leading, spacing: 16){
            Text(viewModel.selectedItem?.name ?? "name").font(.title)
            Text(viewModel.selectedItem?.category ?? "category").font(.caption)
            HStack(spacing: 16){
                TextField("Value", value: $textValue, format: .number).keyboardType(.decimalPad)
                    .background(.gray)
                    .fixedSize(horizontal: true, vertical: false)
                Text(viewModel.selectedItem?.unit.denominator ?? "Unit")
                    .background(.brown)
                Spacer()
            }
            HStack(alignment: .top){
                DatePicker("Date", selection: $currentDate, displayedComponents: [.date])
                    .datePickerStyle(CompactDatePickerStyle())
                Spacer()
            }
            HStack{
                Spacer()
                Button("Add", action: {
                    viewModel.addItemToStore(value: textValue, date: currentDate)
                    dismiss()
                    isPresented = false
                })
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.accentColor)
                    .cornerRadius(8)
                Spacer()
            }
        }.padding()
    }
}

struct CarbonItemDrawerView_Previews: PreviewProvider {
    static var previews: some View {
        CarbonItemDrawerView(isPresented: .constant(true))
            .previewLayout(.fixed(width: 300, height: 700))
    }
}
