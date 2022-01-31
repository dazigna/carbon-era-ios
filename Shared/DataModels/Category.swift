//
//  Category.swift
//  carbonera
//
//  Created by Yacine Alami on 24/01/2022.
//

import Foundation

struct Category: Identifiable, Hashable {
    let parent: String?
    let name: String
    let children: [Category]? = nil
    let cursor: String
    
    var id: String {
       cursor
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.id == rhs.id
    }
}
