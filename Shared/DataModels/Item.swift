//
//  Items.swift
//  carbonera
//
//  Created by Yacine Alami on 20/01/2022.
//

import Foundation

struct Item: Hashable, Identifiable{
    let id = UUID()
    let name: String?
    let totalPoste: Float?
    let unit: Unit?
    let unitStr: String?
}
