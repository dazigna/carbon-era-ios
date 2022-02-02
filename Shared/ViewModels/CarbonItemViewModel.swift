//
//  CarbonItemViewModel.swift
//  carbonera
//
//  Created by Yacine Alami on 20/01/2022.
//

import Foundation
import Apollo

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
    
    // MARK: - Category
    func fetchCategories(first: Int = ConfigurationConstants.numberItemsToFetch){
        self.networkManager.fetchCategories(first: first, cursor: categoryCursor)
            .sink(onError: { err in
                self.errorMsg = err.localizedDescription
                print(self.errorMsg)
        }, receiveValue: { res in
            self.processCategories(result: res.data?.categories?.fragments.categoryDetails)
        })
    }

    func fetchCategoriesForParent(parentName: String, first: Int = ConfigurationConstants.numberItemsToFetch){
        self.networkManager.fetchCategoriesForParent(parentName: parentName, first: first, cursor: self.categoryCursor)
            .sink(onError: { err in
                self.errorMsg = err.localizedDescription
                print(self.errorMsg)
        }, receiveValue: { res in
            self.processCategories(result: res.data?.categories?.fragments.categoryDetails)
        })
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
            self.processCategories(result: res.data?.categories?.fragments.categoryDetails)
        })
    }
    
    func processCategories(result: GraphCarbon.CategoryDetails?){
        guard let res = result else { return }
        self.categoryCursor =  res.pageInfo.endCursor
    
        let nodes = res.edges.compactMap{($0?.node, $0?.cursor)}

        let newCategories = nodes.compactMap{ (item, cursor) -> Category? in
            guard let it = item,
                  let cur = cursor,
                  let name = it.name,
                  let parent = it.parent,
                  let uuid = UUID(uuidString: it.uuid)
            else { return nil }
            return Category(id: uuid, parent: parent.name, name: name, cursor: cur)
        }

        self.categories.append(contentsOf: newCategories)
    }
    
    func checkIfCategoryFetchNeeded(cat: Category){
        if self.categoryCursor == cat.cursor, let parent = cat.parent{
            print("fetching sub cats")
            self.fetchCategoriesForParent(parentName: parent, first: 20)
        }
    }

    func getSubCategories(parentCategory: Category) -> [Category] {
        return self.categories.filter{$0.parent == parentCategory.name}
    }
    
    func fetchItems(forCategory category: Category, first: Int = ConfigurationConstants.numberItemsToFetch){
        self.networkManager.fetchItemsForCategory(categoryName: category.name, first: first, cursor: self.itemsCursor)
            .sink(onError: { err in
                self.errorMsg = err.localizedDescription
            }, receiveValue: { res in
                self.processItems(result: res.data?.items?.fragments.itemDetails)
        })
    }
    
    func processItems(result: GraphCarbon.ItemDetails?){
        guard let res = result else { return }
        self.itemsCursor = res.pageInfo.endCursor
        
        let nodes = res.edges.compactMap{($0?.node, $0?.cursor)}
        
        let newItems = nodes.compactMap{(item, cursor) -> Item? in
            guard let it = item,
                  let cur = cursor,
                  let uuid = UUID(uuidString: it.uuid),
                  let co2Value = it.totalPoste?.toFloat,
                  let unit = unwrapUnit(u: it.unit?.fragments.unitDetails),
                  let unitstr = it.unitStr
            else { return nil }
            return Item(
                id: uuid,
                name: it.nameFr,
                totalPoste: co2Value,
                unit: unit,
                unitStr: unitstr,
                cursor: cur)
        }

        self.items.append(contentsOf: newItems)
    }
    
    func unwrapUnit(u: GraphCarbon.UnitDetails?) -> Unit?{
        guard let unit = u,
              let uuid = UUID(uuidString: unit.uuid),
              let name = unit.name,
              let den = unit.denominator,
              let num = unit.numerator,
              let q = unit.quantity,
              let type = UnitType(rawValue: q)
        else { return nil }
        
        return Unit(id: uuid, name: name, type: type, numerator: num, denominator: den)
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
