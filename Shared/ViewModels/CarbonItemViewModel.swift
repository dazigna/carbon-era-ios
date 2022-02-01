//
//  CarbonItemViewModel.swift
//  carbonera
//
//  Created by Yacine Alami on 20/01/2022.
//

import Foundation

protocol CarbonItemProtocol{
    var networkManager: BaseNetworkInterface { get }
//    func fetchItems()
    func fetchCategories()
}

class CarbonItemViewModel: ObservableObject{
    
    @Published var items: [Item] = []
    @Published var errorMsg: String?
    @Published var categories: [Category] = []
    @Published var subCategories: [Category] = []
    @Published var searchText: String = ""
    
    var networkManager: BaseNetworkInterface
    var store: StorageInterface
    
    var categoryCursor: String? = nil
    var itemsCursor: String? = nil
    
    let numberOfItemsToFetch = 20
    
    init(networkM: BaseNetworkInterface = NetworkManager(), store: StorageInterface = CarbonStore()!){
        self.networkManager = networkM
        self.store = store
    }
    
    func cleanUpSubCategories(){
        //Only clean up if items are non-existing
        if(self.items.isEmpty){
            self.subCategories = []
            self.categoryCursor = nil
        }
    }
    
    func cleanUpItems(){
        self.items = []
        self.itemsCursor = nil
    }
    
    func fetchCategories(first: Int = ConfigurationConstants.numberItemsToFetch){
        self.networkManager.fetchCategories(first: first, cursor: categoryCursor)
            .sink(onError: { err in
                self.errorMsg = err.localizedDescription
                print(self.errorMsg)
        }, receiveValue: { res in
            self.categoryCursor =  res.data?.categories?.pageInfo.endCursor

            let nodes = res.data?.categories?.edges.compactMap{($0?.node, $0?.cursor)}

            let newCategories = nodes?.compactMap{ (item, cursor) -> Category? in
                guard let it = item, let cur = cursor else { return nil}
                return Category(parent: it.parent?.name, name: it.name!, cursor: cur)
            }

            if let newCats = newCategories{
                self.categories.append(contentsOf: newCats)
            }
        })
    }
    
    
    func fetchCategoriesForParent(parentName: String, first: Int = ConfigurationConstants.numberItemsToFetch){
        self.networkManager.fetchCategoriesForParent(parentName: parentName, first: first, cursor: self.categoryCursor)
            .sink(onError: { err in
                self.errorMsg = err.localizedDescription
                print(self.errorMsg)
        }, receiveValue: { res in
            self.categoryCursor =  res.data?.categories?.pageInfo.endCursor

            let nodes = res.data?.categories?.edges.compactMap{($0?.node, $0?.cursor)}

            let newCategories = nodes?.compactMap{ (item, cursor) -> Category? in
                guard let it = item, let cur = cursor else { return nil}
                return Category(parent: it.parent?.name, name: it.name!, cursor: cur)
            }

            if let newCats = newCategories{
                self.subCategories.append(contentsOf: newCats)
            }
        })
    }
    
    func checkIfCategoryFetchNeeded(cat: Category){
        if self.categoryCursor == cat.cursor, let parent = cat.parent{
            print("fetching sub cats")
            self.fetchCategoriesForParent(parentName: parent, first: 20)
        }
    }

    func getParentCategories(){
        if !self.categories.isEmpty{
            return
        }
        self.networkManager.fetchParentCategories()
            .sink(onError: { err in
                self.errorMsg = err.localizedDescription
                print(self.errorMsg)
        }, receiveValue: { res in
            let nodes = res.data?.categories?.edges.compactMap{($0?.node, $0?.cursor)}

            let newCategories = nodes?.compactMap{ (item, cursor) -> Category? in
                guard let it = item, let cur = cursor else { return nil}
                return Category(parent: it.parent?.name, name: it.name!, cursor: cur)
            }

            if let newCats = newCategories{
                self.categories.append(contentsOf: newCats)
                print(self.categories.map{$0.cursor})
            }
        })
    }
    
    func getSubCategories(parentCategory: Category) -> [Category] {
        return self.categories.filter{$0.parent == parentCategory.name}
    }
    
    func fetchItems(forCategory category: Category, first: Int = ConfigurationConstants.numberItemsToFetch){
        self.networkManager.fetchItemsForCategory(categoryName: category.name, first: first, cursor: self.itemsCursor)
            .sink(onError: { err in
                self.errorMsg = err.localizedDescription
            }, receiveValue: { res in
                self.itemsCursor = res.data?.items?.pageInfo.endCursor
                
                let nodes = res.data?.items?.edges.compactMap{($0?.node, $0?.cursor)}
                
                let newItems = nodes?.compactMap{(item, cursor) -> Item? in
                    guard let it = item,
                          let cur = cursor,
                          let co2Value = it.totalPoste?.toFloat
                    else { return nil }
                    return Item(name: it.nameFr, totalPoste: co2Value, unit: Unit(name: it.unit?.name, quantity: it.unit?.quantity), unitStr: it.unitStr, cursor: cur)
                }
                
                if let newIt = newItems{
                    self.items.append(contentsOf: newIt)
                }
        })
    }
    
    func addItemToStore(item: Item, value: Float){
        self.store.write(StoredCarbonItem(name: item.name!, value: value, quantity: item.unit!.quantity!, cursor: item.cursor)){ res in
            switch res {
            case .success(_):
                print("save success")
            case .failure(let error):
                print("Error save \(error)")
            }
        }
    }
}

extension Double{
    var toFloat: Float{
        Float(self)
    }
}
