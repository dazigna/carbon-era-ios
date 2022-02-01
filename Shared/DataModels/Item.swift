//
//  Items.swift
//  carbonera
//
//  Created by Yacine Alami on 20/01/2022.
//

import Foundation

struct Item: Identifiable{
    let name: String?
    let totalPoste: Float?
    let unit: Unit?
    let unitStr: String?
    let category: Category? = nil
    var cursor: String
    
    var id: String {
        cursor
    }
}
