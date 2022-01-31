//
//  Unit.swift
//  carbonera
//
//  Created by Yacine Alami on 20/01/2022.
//

import Foundation

struct Unit: Identifiable{
    let id = UUID()
    let name: String?
    let quantity: String?
    
    init(name: String? = nil, quantity: String? = nil){
        self.name = name
        self.quantity = quantity
    }
}
