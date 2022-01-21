//
//  CarbonItemViewModel.swift
//  carbonera
//
//  Created by Yacine Alami on 20/01/2022.
//

import Foundation

protocol CarbonItemProtocol{
    func fetchItems()
}
class CarbonItemViewModel: ObservableObject{
    
    @Published var items: [Item]?
    @Published var errorMsg: String?
    let networkManager: NetworkManager
    init(networkM: NetworkManager = NetworkManager()){
        self.networkManager = networkM
    }
    
    func fetchItems(){
        self.networkManager.fetchItems().sink(onError: { err in
            self.errorMsg = err.localizedDescription
        }, receiveValue: { res in
            self.items = res.data?.allItems?.compactMap({ t -> Item? in
                guard let tu = t else {return nil}
                return Item(name: tu.nameFr!, totalPoste: Float(tu.totalPoste!), unit: Unit(name:"fake", quantity: "fake"), unitStr: tu.unitStr!)
            })
        })
    }
}
