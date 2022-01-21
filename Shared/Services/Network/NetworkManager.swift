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
    func fetchItems() -> Publishers.ApolloFetch<GetItemsQuery>
}

class NetworkManager: BaseNetworkInterface{
    
    private var client: ApolloClient
    
    init(client: ApolloClient = ApolloClient(url: URL(string: "http://localhost:8000/webapi/graphql")!)){
        self.client = client
    }
    
    func fetchItems() -> Publishers.ApolloFetch<GetItemsQuery> {
        return self.client.fetchPublisher(query: GetItemsQuery())
    }
}
