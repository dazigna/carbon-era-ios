//
//  ConfigurationManager.swift
//  carbonera
//
//  Created by Yacine Alami on 20/01/2022.
//

import Foundation

enum ConfigurationConstants {
    static let numberItemsToFetch:Int = 20
    static let serverUrl = URL(string: "http://localhost:8000/api/graphql")!
    static let carbonItemsStoredFilename: String = "carbon.json"
}
