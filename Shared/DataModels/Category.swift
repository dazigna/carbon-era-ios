//
//  Category.swift
//  carbonera
//
//  Created by Yacine Alami on 24/01/2022.
//

import Foundation

struct Category: Identifiable {
    let id: UUID
    let parent: String?
    let name: String
    let cursor: String
    
    static func fake() -> Category {
        return Category(id: UUID(), parent: "fakeParent", name: "fake category", cursor: "fakeCursor")
    }
}
