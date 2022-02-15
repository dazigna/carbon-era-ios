//
//  NavigationController.swift
//  carbonera (iOS)
//
//  Created by Yacine Alami on 15/02/2022.
//

import Foundation
enum Tabs:Hashable{
    case stats
    case items
    case map
}

//https://nalexn.github.io/swiftui-deep-linking/?utm_source=forums.developer.apple.com
class ViewRouter: ObservableObject {
    @Published var selectedTab: Tabs = .stats
    @Published var showActionSheet: Bool = false
}
