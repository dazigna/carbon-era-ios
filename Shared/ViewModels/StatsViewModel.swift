//
//  StatsViewModel.swift
//  carbonera (iOS)
//
//  Created by Yacine Alami on 03/02/2022.
//

import Foundation

class StatsViewModel: ObservableObject{
    
    @Published var totalFootprint: Double = 0.0
    
    var store: StorageInterface
    
    init(store: StorageInterface = CarbonStore()!){
        self.store = store
        getFootprint()
    }
    
    func getFootprint(){
        self.totalFootprint = store.content.map({$0.measure.value}).reduce(0, +)
    }
    
    func clearData(){
        store.clear { res in
            print("data cleared ?")
            print(res)
            DispatchQueue.main.async {
                self.totalFootprint = 0
            }
        }
    }
}
