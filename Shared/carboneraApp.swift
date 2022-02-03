//
//  carboneraApp.swift
//  Shared
//
//  Created by Yacine Alami on 13/01/2022.
//

import SwiftUI
import PartialSheet
@main
struct carboneraApp: App {
    init(){

    }
        
    var body: some Scene {
        WindowGroup{
            MainView()
                .environmentObject(PartialSheetManager())

        }
    }
}
