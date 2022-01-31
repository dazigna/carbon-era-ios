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
//    func fetchItems() -> Publishers.ApolloFetch<GetItemsQuery>
    func fetchParentCategories() -> Publishers.ApolloFetch<GetParentCategoriesQuery>
    func fetchCategoriesForParent(parentName: String, first: Int, cursor: String?) -> Publishers.ApolloFetch<GetCategoriesForParentQuery>
    func fetchCategories(first: Int, cursor: String?) -> Publishers.ApolloFetch<GetCategoriesQuery>
    func fetchItemsByCategory(categoryName: String) -> Publishers.ApolloFetch<GetItemsByCategoryQuery>
}

class NetworkManager: BaseNetworkInterface{
    
    private var client: ApolloClient
    
    init(client: ApolloClient = ApolloClient(url: ConfigurationManager().serverUrl)){
        self.client = client
    }
    
//    func fetchItems() -> Publishers.ApolloFetch<GetItemsQuery> {
//        return self.client.fetchPublisher(query: GetItemsQuery())
//    }
    
    func fetchCategories(first: Int, cursor: String? = nil) -> Publishers.ApolloFetch<GetCategoriesQuery> {
        return self.client.fetchPublisher(query: GetCategoriesQuery(cursor: cursor, first: first))
    }
    
    func fetchCategoriesForParent(parentName: String, first: Int, cursor: String? = nil) -> Publishers.ApolloFetch<GetCategoriesForParentQuery> {
        return self.client.fetchPublisher(query: GetCategoriesForParentQuery(parentName: parentName, cursor: cursor, first: first))
    }
    
    func fetchParentCategories() -> Publishers.ApolloFetch<GetParentCategoriesQuery>{
        return self.client.fetchPublisher(query: GetParentCategoriesQuery())
    }
    
    func fetchItemsByCategory(categoryName: String) -> Publishers.ApolloFetch<GetItemsByCategoryQuery> {
        return self.client.fetchPublisher(query: GetItemsByCategoryQuery(categoryName: categoryName))
    }
}
