//
//  Unit.swift
//  carbonera
//
//  Created by Yacine Alami on 20/01/2022.
//

import Foundation

enum UnitType: String, Codable {
    case energy = "ENERGY"
    case mass = "MASS"
    case volume = "VOLUME"
    case area = "AREA"
    case distance = "DISTANCE"
    case time = "TIME"
    case quantity = "QUANTITY"
}

struct Unit: Identifiable, Codable{
    let id: UUID
    let name: String
    let type: UnitType
    let numerator: String
    let denominator: String
    
    static func fake() -> Unit{
        return Unit(id: UUID(), name: "fakeUnit", type: .mass, numerator: "numerator", denominator: "denom")
    }
}
