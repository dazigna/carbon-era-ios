//
//  Items.swift
//  carbonera
//
//  Created by Yacine Alami on 20/01/2022.
//

import Foundation

struct Item: Identifiable{
    let id: UUID
    let name: String?
    let totalPoste: Float?
    let unit: Unit?
    let unitStr: String?
    let category: Category? = nil
    let cursor: String
    
    static func fake() -> Item {
        return Item(
            id: UUID(),
            name: "Fake Item",
            totalPoste: 123.123,
            unit: Unit.fake(),
            unitStr: "unitstr",
            cursor: "cursor")
    }
}
