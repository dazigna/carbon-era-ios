//
//  CarbonStore.swift
//  carbonera
//
//  Created by Yacine Alami on 01/02/2022.
//

import Foundation

protocol StorageInterface {
    var content: [StoredCarbonItem] { get }
    func read(completion: @escaping (Result<[StoredCarbonItem], Error>) -> Void)
    func write(_ value: StoredCarbonItem, completion: @escaping (Result<Bool, Error>) -> Void)
    func update(_ value: StoredCarbonItem, completion: @escaping (Result<StoredCarbonItem, Error>) -> Void)
    func delete(_ value: StoredCarbonItem, completion: @escaping (Result<[StoredCarbonItem], Error>) -> Void)
    func clear(completion: @escaping (Result<Bool, Error>) -> Void)
}

class CarbonStore: StorageInterface {
    
    private let queue = DispatchQueue(label: "SugarcubeFileIOQueue", qos: .background, attributes: .concurrent)
    private var savedDirectoryUrl: URL
    private var savedFileUrl: URL
    
    public var content: [StoredCarbonItem] = []
    
    init?(){
        guard let applicationSupportUrl = try? FileManager.default.url(
            for: .applicationSupportDirectory,
               in: .userDomainMask,
               appropriateFor: nil,
               create: false)
        else {
            return nil
        }
        self.savedDirectoryUrl = applicationSupportUrl.appendingPathComponent(ConfigurationConstants.storeDirectory)
        self.savedFileUrl = self.savedDirectoryUrl.appendingPathComponent(ConfigurationConstants.carbonItemsStoredFilename)

        if !(FileManager.default.fileExists(atPath: self.savedDirectoryUrl.relativePath)) {
              guard (try? FileManager.default.createDirectory(at: self.savedDirectoryUrl, withIntermediateDirectories: true, attributes: nil)) != nil else {
                  return nil
              }
        }
        print("Saving url is \(self.savedFileUrl.absoluteString)" )
        self.content = unsafeRead()
        print("Store content:")
        print(self.content)
    }
    
    func unsafeRead() -> [StoredCarbonItem] {
        var contentArray: [StoredCarbonItem] = []
        queue.sync {
            if let data = try? Data(contentsOf: self.savedFileUrl),
               let readContent = try? JSONDecoder().decode([StoredCarbonItem].self, from: data) {
                contentArray = readContent
            }
        }
        return contentArray
    }
    
    func read(completion: @escaping (Result<[StoredCarbonItem], Error>) -> Void){
        queue.sync {
            if content.isEmpty {
                do {
                    let data = try Data(contentsOf: self.savedFileUrl)
                    self.content = try JSONDecoder().decode([StoredCarbonItem].self, from: data)
                    completion(.success(self.content))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.success(content))
            }
        }
    }
    
    
    func write(_ value: StoredCarbonItem, completion: @escaping (Result<Bool, Error>) -> Void) {
        queue.async(flags: .barrier) {
            do {
                self.content.append(value)
                let data = try  JSONEncoder().encode(self.content)
                try data.write(to: self.savedFileUrl, options: .atomic)
                completion(.success(true))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func update(_ value: StoredCarbonItem, completion: @escaping (Result<StoredCarbonItem, Error>) -> Void) {
        queue.async(flags: .barrier) {
            if let index = self.content.firstIndex(where: {$0.cursor == value.cursor}) {
                self.content[index] = value
                do {
                    let data = try JSONEncoder().encode(self.content)
                    try data.write(to: self.savedFileUrl, options: .atomic)
                    completion(.success(self.content[index]))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func delete(_ value: StoredCarbonItem, completion: @escaping (Result<[StoredCarbonItem], Error>) -> Void) {
        queue.async(flags: .barrier) {
            self.content.removeAll(where: {$0.cursor == value.cursor})
            do {
                let data = try JSONEncoder().encode(self.content)
                try data.write(to: self.savedFileUrl, options: .atomic)
                completion(.success(self.content))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func clear(completion: @escaping (Result<Bool, Error>) -> Void) {
        queue.async(flags: .barrier) {
            self.content.removeAll()
            self.writeToFile(value: self.content, completion: completion)
        }
    }
    
    private func writeToFile(value: [StoredCarbonItem], completion: @escaping (Result<Bool, Error>) -> Void) {
        do {
            let data = try JSONEncoder().encode(value)
            try data.write(to: self.savedFileUrl, options: .atomic)
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }
}
