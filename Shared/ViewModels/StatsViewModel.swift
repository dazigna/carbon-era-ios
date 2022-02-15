//
//  StatsViewModel.swift
//  carbonera (iOS)
//
//  Created by Yacine Alami on 03/02/2022.
//

import Foundation

struct SortedStoredCarbonItem: Identifiable{
    let id = UUID()
    
    let date: Date
    let items: [StoredCarbonItem]
}

class StatsViewModel: ObservableObject{
    
    @Published var totalFootprint: Double = 0.0
    @Published var items: [SortedStoredCarbonItem] = []
    
    var store: StorageInterface
    
    init(store: StorageInterface){
        self.store = store
    }
    
    func load(){
        items = sortArray()
        computeFootprint()
    }
    
    func sortArray() -> [SortedStoredCarbonItem]{
        var sortedArray: [SortedStoredCarbonItem] = []
//        let dates = self.store.content.map{$0.date}
        
        //Get Unique dates
        var order = [Date]()
        var set = Set<DateComponents>()

        let dates = self.store.content.compactMap{ item -> Date? in
            let components = Calendar.current.dateComponents([.day,.month, .year], from: item.date)
            if !set.contains(components){
                set.insert(components)
                return item.date
            }
            return nil
        }

        
        for d in dates{
            let it = self.store.content.filter( {Calendar.current.isDate($0.date, equalTo: d, toGranularity: .day)} )
            sortedArray.append(SortedStoredCarbonItem(date: d, items: it))
        }
        
        print(sortedArray)
        return sortedArray
    }
    
    func computeFootprint(){
        self.totalFootprint = store.content.map({$0.measure.value}).reduce(0, +)
    }
    
    func clearData(){
        store.clear { res in
            print("data cleared ?")
            print(res)
            DispatchQueue.main.async {
                self.totalFootprint = 0
                self.items = []
            }
        }
    }
}
