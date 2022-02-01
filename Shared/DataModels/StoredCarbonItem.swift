//
//  StoredCarbonItem.swift
//  carbonera
//
//  Created by Yacine Alami on 01/02/2022.
//

import Foundation

struct StoredCarbonItem: Codable {
    let name: String
    let value: Float
    let quantity: String
    let cursor: String
}
