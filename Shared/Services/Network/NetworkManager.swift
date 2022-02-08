//
//  NetworkManager.swift
//  carbonera
//
//  Created by Yacine Alami on 20/01/2022.
//

import Foundation
import Apollo
import ApolloCombine
import Combine

extension Publisher {
    func ignore() {
        receive(subscriber: Subscribers.Sink(receiveCompletion: { _ in }, receiveValue: { _ in }))
    }
    
    func sink(onError: @escaping (Self.Failure) -> Void, receiveValue: @escaping (Self.Output) -> Void) {
        receive(subscriber: Subscribers.Sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                onError(error)
            case .finished:
                break
            }
        }, receiveValue: receiveValue))
    }
}

//Weakly assign, because combine leaks otherwise
extension Publisher where Failure == Never {
    func assign<Root: AnyObject>(to keyPath: ReferenceWritableKeyPath<Root, Output>, on root: Root) -> AnyCancellable {
        sink { [weak root] in
            root?[keyPath: keyPath] = $0
        }
    }
}

protocol BaseNetworkInterface{
    func searchItems(forName name: String) -> Publishers.ApolloFetch<GraphCarbon.SearchItemsQuery>
    func getItem(forName name: String) -> Publishers.ApolloFetch<GraphCarbon.GetSingleItemQuery>
    func fetchItemsForCategory(categoryName: String, first: Int?, cursor: String?) -> Publishers.ApolloFetch<GraphCarbon.GetItemsByCategoryQuery>
    func fetchParentCategories() -> Publishers.ApolloFetch<GraphCarbon.GetParentCategoriesQuery>
    func fetchCategoriesForParent(parentName: String, first: Int, cursor: String?) -> Publishers.ApolloFetch<GraphCarbon.GetCategoriesForParentQuery>
    func fetchCategories(first: Int, cursor: String?) -> Publishers.ApolloFetch<GraphCarbon.GetCategoriesQuery>
    func fecthUnits() -> Publishers.ApolloFetch<GraphCarbon.GetUnitsQuery>
}

class NetworkManager: BaseNetworkInterface{
    
    private var client: ApolloClient
    
    init(client: ApolloClient = ApolloClient(url: ConfigurationConstants.serverUrl)){
        self.client = client
    }
    
    func fetchItemsForCategory(categoryName: String, first: Int? = nil, cursor: String? = nil) -> Publishers.ApolloFetch<GraphCarbon.GetItemsByCategoryQuery> {
        return self.client.fetchPublisher(query: GraphCarbon.GetItemsByCategoryQuery(categoryName: categoryName, cursor: cursor, first: first))
    }
    
    func fetchCategories(first: Int, cursor: String? = nil) -> Publishers.ApolloFetch<GraphCarbon.GetCategoriesQuery> {
        return self.client.fetchPublisher(query: GraphCarbon.GetCategoriesQuery(cursor: cursor, first: first))
    }
    
    func fetchCategoriesForParent(parentName: String, first: Int, cursor: String? = nil) -> Publishers.ApolloFetch<GraphCarbon.GetCategoriesForParentQuery> {
        return self.client.fetchPublisher(query: GraphCarbon.GetCategoriesForParentQuery(parentName: parentName, cursor: cursor, first: first))
    }
    
    func fetchParentCategories() -> Publishers.ApolloFetch<GraphCarbon.GetParentCategoriesQuery>{
        return self.client.fetchPublisher(query: GraphCarbon.GetParentCategoriesQuery())
    }
    
    func fecthUnits() -> Publishers.ApolloFetch<GraphCarbon.GetUnitsQuery>{
        return self.client.fetchPublisher(query: GraphCarbon.GetUnitsQuery())
    }
    
    func searchItems(forName name: String) -> Publishers.ApolloFetch<GraphCarbon.SearchItemsQuery>{
        return self.client.fetchPublisher(query: GraphCarbon.SearchItemsQuery(searchName: name))
    }
    
    func getItem(forName name: String) -> Publishers.ApolloFetch<GraphCarbon.GetSingleItemQuery>{
        return self.client.fetchPublisher(query: GraphCarbon.GetSingleItemQuery(name: name))
    }
}
