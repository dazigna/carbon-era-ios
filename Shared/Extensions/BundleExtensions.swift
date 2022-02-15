//
//  BundleExtensions.swift
//  carbonera (iOS)
//
//  Created by Yacine Alami on 09/02/2022.
//

import Foundation

extension Bundle {
    func getLocalizedOrNotValue(key: String) -> Any? {
        if let value =  Bundle.main.localizedInfoDictionary?[key] {
            return value
        } else if let value = Bundle.main.infoDictionary?[key] {
            return value
        }
        return nil
    }
    
    var mapBoxToken: String? {
        return getLocalizedOrNotValue(key: "MBXAccessToken") as? String
    }
    
    var releaseVersionNumber: String? {
        return getLocalizedOrNotValue(key: "CFBundleShortVersionString") as? String
    }
    
    var buildVersionNumber: String? {
        return getLocalizedOrNotValue(key: "CFBundleVersion") as? String
    }
    
    var releaseVersionNumberPretty: String {
        return "\(releaseVersionNumber!)-\(buildVersionNumber!)"
    }
    
    var applicationName: String? {
        guard let appName = getLocalizedOrNotValue(key: "CFBundleDisplayName") as? String else {return getLocalizedOrNotValue(key: "CFBundleName") as? String}
        return appName
     }

    //Need to address the Telemetry class  to make it not static before we can remove this duplicate with the configurationManager
    // Checks wether it's a prod build or a debug build
    var provisioningProfile: String {
        #if IOS_SIMULATOR
        return "development"
        #else
        // there will be no provisioning profile in AppStore Apps
        guard let fileName = Bundle.main.path(forResource: "embedded", ofType: "mobileprovision"),
              let data = try? String(contentsOf: URL(fileURLWithPath: fileName), encoding: .ascii)
              else {
            return "production"
        }
        let cleared: String = data.components(separatedBy: .whitespacesAndNewlines).joined()
        return cleared.contains("<key>get-task-allow</key><true/>") ? "production" : "development"
        #endif
    }
}
