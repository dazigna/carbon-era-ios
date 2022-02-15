//
//  DateExtensions.swift
//  carbonera (iOS)
//
//  Created by Yacine Alami on 15/02/2022.
//

import Foundation

extension Date{
    func toString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: self)
    }
}
