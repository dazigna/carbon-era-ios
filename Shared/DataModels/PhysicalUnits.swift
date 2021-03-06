//
//  PhysicalUnits.swift
//  carbonera
//
//  Created by Yacine Alami on 03/02/2022.
//

import Foundation

extension UnitMass{
    static let kgCO2e = UnitMass(symbol: "kgCO2e", converter: UnitConverterLinear(coefficient: 1.0))
}

extension Measurement{
    func formattedWithBaseUnit() -> String{
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        return formatter.string(from: self)
    }
}
