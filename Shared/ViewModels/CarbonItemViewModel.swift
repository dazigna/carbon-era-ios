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
    
    @Published var categories: [Category] = []
    @Published var selectedCategory: Category? = nil
    
    @Published var subCategories: [Category] = []
    @Published var selectedSubCategory: Category? = nil
    
    @Published var items: [Item] = []
    @Published var selectedItem: Item? = nil
    
    @Published var searchText: String = ""
    @Published var presentAlert: Bool = false
        
    var errorMsg: String?{
        didSet{
            if errorMsg != nil {
                self.presentAlert = true
            }
            self.presentAlert = false
        }
    }
    
    var networkManager: BaseNetworkInterface
    var store: StorageInterface
    
    var units: [Unit] = []
    
    var categoryCursor: String? = nil
    var subCategoryCursor: String? = nil
    var itemsCursor: String? = nil
    
    let numberOfItemsToFetch = 20
    
    init(networkM: BaseNetworkInterface = NetworkManager(), store: StorageInterface = CarbonStore()!){
        self.networkManager = networkM
        self.store = store
    }
    
    func cleanUpSubCategories(){
        self.subCategories = []
        self.subCategoryCursor = nil
    }
    
    func cleanUpItems(){
        self.items = []
        self.itemsCursor = nil
        self.selectedItem = nil
    }
    
    func cleanError(){
        self.errorMsg = nil
    }
    
    // MARK: - Category
    func fetchCategories(first: Int = ConfigurationConstants.numberItemsToFetch){
        self.networkManager.fetchCategories(first: first, cursor: categoryCursor)
            .sink(onError: { err in
                self.errorMsg = err.localizedDescription
                print(self.errorMsg)
        }, receiveValue: { res in
            self.categories = self.processCategories(result: res.data?.categories?.fragments.categoryDetails)
        })
    }

    func fetchCategoriesForParent(){
        guard let parent = self.selectedCategory else { return }
        self.fetchCategoriesForParent(parentName: parent.name)
    }
    
    private func fetchCategoriesForParent(parentName: String, first: Int = ConfigurationConstants.numberItemsToFetch){
        self.networkManager.fetchCategoriesForParent(parentName: parentName, first: first, cursor: self.subCategoryCursor)
            .sink(onError: { err in
                self.errorMsg = err.localizedDescription
                print(self.errorMsg)
        }, receiveValue: { res in
            self.subCategories.append(contentsOf: self.processCategories(result: res.data?.categories?.fragments.categoryDetails))
            self.subCategoryCursor = res.data?.categories?.pageInfo.endCursor
        })
    }
    
    func getParentCategories(){
        if self.categories.contains(where: {$0.cursor ==  self.categoryCursor}){
            print("NO FETCHING")
            return
        }
        
        self.networkManager.fetchParentCategories()
            .sink(onError: { err in
                self.errorMsg = err.localizedDescription
                print(self.errorMsg)
        }, receiveValue: { res in
            self.categories.append(contentsOf: self.processCategories(result: res.data?.categories?.fragments.categoryDetails))
            self.categoryCursor = res.data?.categories?.pageInfo.endCursor
        })
    }
    
    func processCategories(result: GraphCarbon.CategoryDetails?) -> [Category]{
        guard let res = result else { return []}
    
        let nodes = res.edges.compactMap{($0?.node, $0?.cursor)}

        let newCategories = nodes.compactMap{ (item, cursor) -> Category? in
            guard let it = item,
                  let cur = cursor,
                  let name = it.name,
                  let uuid = UUID(uuidString: it.uuid)
            else {
                self.errorMsg = "Error parsing categories"
                self.presentAlert = true
                return nil
            }
            return Category(id: uuid, parent: it.parent?.name, name: name, cursor: cur)
        }
        
        return newCategories
    }
    
    func checkIfCategoryFetchNeeded(cat: Category){
        if self.subCategoryCursor == cat.cursor, let parent = cat.parent{
            print("fetching sub cats")
            self.fetchCategoriesForParent(parentName: parent)
        }
    }

    func getSubCategories(parentCategory: Category) -> [Category] {
        return self.categories.filter{$0.parent == parentCategory.name}
    }
    
    //MARK: - Units
    func fetchUnits(){
        self.networkManager.fecthUnits()
            .sink(onError: { err in
                self.errorMsg = err.localizedDescription
            }, receiveValue: { res in
                guard let result = res.data?.units?.edges else { return }
                
                let nodes = result.compactMap{$0?.node}
                
                self.units = nodes.compactMap{self.unwrapUnit(u: $0.fragments.unitDetails)}
            })
    }
    
    // MARK: - Items
    func fetchItems(){
        guard let subCat = self.selectedSubCategory else { return }
        self.fetchItems(forCategory: subCat)
    }
    
    private func fetchItems(forCategory category: Category, first: Int = ConfigurationConstants.numberItemsToFetch){
        self.networkManager.fetchItemsForCategory(categoryName: category.name, first: first, cursor: self.itemsCursor)
            .sink(onError: { err in
                self.errorMsg = err.localizedDescription
            }, receiveValue: { res in
                self.processItems(result: res.data?.items?.fragments.itemDetails)
        })
    }
    
    func checkIfItemFetchNeeded(item: Item){
        if self.itemsCursor == item.cursor{
            print("fetching new items")
            self.fetchItems()
        }
    }

    func processItems(result: GraphCarbon.ItemDetails?){
        guard let res = result else { return }
        self.itemsCursor = res.pageInfo.endCursor
        
        let nodes = res.edges.compactMap{($0?.node, $0?.cursor)}
        
        let newItems = nodes.compactMap{(item, cursor) -> Item? in
            guard let it = item,
                  let cur = cursor,
                  let uuid = UUID(uuidString: it.uuid),
                  let name = it.nameFr,
                  let co2Value = it.totalPoste,
                  let unit = unwrapUnit(u: it.unit?.fragments.unitDetails),
                  let unitstr = it.unitStr,
                  let cat = it.categoryStr
            else {
                print("Issue parsing items")
                return nil
            }
            return Item(
                id: uuid,
                name: name,
                totalPoste: co2Value,
                unit: unit,
                unitStr: unitstr,
                category: cat,
                cursor: cur)
        }
        
        print("New items: \(newItems.count)")
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
    
    // MARK: - Addition
    func addItemToStore(value: Double, date: Date){
        guard let item = selectedItem else { return }
        let measure = Measurement(value: item.totalPoste * value, unit: UnitMass.kgCO2e)
        let itemToStore = StoredCarbonItem(name: item.name, measure: measure, type: item.unit.type.rawValue, cursor: item.cursor, date: date)
        self.store.write(itemToStore){ res in
            switch res {
            case .success(_):
                print("save success")
            case .failure(let error):
                print("Error save \(error)")
            }
        }
        selectedItem = nil
    }
}

extension Double{
    var toFloat: Float{
        Float(self)
    }
}
