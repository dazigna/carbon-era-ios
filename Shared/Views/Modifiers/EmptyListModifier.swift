//
//  EmptyModifier.swift
//  carbonera
//
//  Created by Yacine Alami on 21/01/2022.
//

import SwiftUI

struct EmptyListModifier<PlaceHolderView: View>: ViewModifier {
    
    let items: [Any]
    let placeHolderView: PlaceHolderView
    
    func body(content: Content) -> some View {
        if items.isEmpty {
            placeHolderView
        } else {
            content
        }
    }
}

extension View{
    func emptyList<PlaceHolderView: View>(_ items: [Any], _ placeHolderView: @escaping () -> PlaceHolderView) -> some View{
        modifier(EmptyListModifier(items: items, placeHolderView: placeHolderView()))
    }
}
