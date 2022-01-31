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
    
    @Published var items: [Item]?
    @Published var errorMsg: String?
    @Published var categories: [Category] = []
    @Published var subCategories: [Category] = []
    @Published var searchText: String = ""
    
    var networkManager: BaseNetworkInterface
    
    var categoryCursor: String? = nil

    init(networkM: BaseNetworkInterface = NetworkManager()){
        self.networkManager = networkM
    }
//    func fetchItems(){
//        self.networkManager.fetchItems().sink(onError: { err in
//            self.errorMsg = err.localizedDescription
//        }, receiveValue: { res in
//
//            self.items = self.extractItems(itemData: res.data?.allItems)
//
////            self.items = res.data?.allItems?.compactMap{ elem -> Item? in
////                guard let item = elem,
////                      let name = item.nameFr,
////                      let poste = item.totalPoste,
////                      let unitStr = item.unitStr
////                else {return nil}
////
////                return Item(name: name,
////                            totalPoste: Float(poste),
////                            unit: Unit(name: item.unit?.name, quantity: item.unit?.quantity),
////                            unitStr: unitStr)
////            }
//        })
//    }
//
    
    func cleanUpSubView(){
        self.subCategories = []
    }
    
    func fetchCategories(first: Int){
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
    
    
    func fetchCategoriesForParent(parentName: String, first: Int){
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
                print(self.subCategories.map{$0.cursor})
            }
        })
    }
    
    func checkIfCategoryFetchNeeded(cat: Category){
        if self.categoryCursor == cat.cursor, let parent = cat.parent{
            print("fetching")
            self.fetchCategoriesForParent(parentName: parent, first: 20)
        }
    }

    func getParentCategories(){
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
            }
        })
    }
    
    func getSubCategories(parentCategory: Category) -> [Category] {
        return self.categories.filter{$0.parent == parentCategory.name}
    }
    
    func getItemsForCategory(category: Category){
//        return self.networkManager.fetchItemsByCategory(categoryName: category.name).sink(onError: { err in
//            self.errorMsg = err.localizedDescription
//        }, receiveValue: { res in
//            print("received")
//            self.items = res.data?.items?.compactMap{ elem -> Item? in
//                guard let item = elem,
//                      let name = item.nameFr,
//                      let poste = item.totalPoste,
//                      let unitStr = item.unitStr
//                else {return nil}
//
//                return Item(name: name,
//                            totalPoste: Float(poste),
//                            unit: Unit(name: item.unit?.name, quantity: item.unit?.quantity),
//                            unitStr: unitStr)
//            }
//        })
    }
    
//    func extractItems(itemData: [GetItemsQuery.Data.Items?]?) -> [Item]{
//        return itemData?.compactMap{ elem -> Item? in
//            guard let item = elem,
//                  let name = item.nameFr,
//                  let poste = item.totalPoste,
//                  let unitStr = item.unitStr
//            else {return nil}
//
//            return Item(name: name,
//                        totalPoste: Float(poste),
//                        unit: Unit(name: item.unit?.name, quantity: item.unit?.quantity),
//                        unitStr: unitStr)
//        } ?? []
//    }
}
