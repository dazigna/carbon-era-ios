//
//  StoredCarbonItem.swift
//  carbonera
//
//  Created by Yacine Alami on 01/02/2022.
//

import Foundation

struct StoredCarbonItem: Codable, Identifiable {
    let id: UUID
    let name: String
    let measure: Measurement<UnitMass>
    let type: String
    let cursor: String
    let date: Date
}
