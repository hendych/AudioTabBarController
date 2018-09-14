//
//  Utils.swift
//  AudioTabBarController
//
//  Created by Hendy Christianto on 13/09/18.
//

import Foundation


class Utils {
    private init() { }
    
    static func loadBundle(for cls: Swift.AnyClass) -> Bundle {
        let podBundle = Bundle(for: cls)
        
        guard let bundleURL = podBundle.url(forResource: "AudioTabBarController",
                                            withExtension: "bundle") else {
            fatalError("Bundle of AudioTabBarController not found")
        }
        
        guard let bundle = Bundle(url: bundleURL) else {
            fatalError("Cannot load bundle")
        }
        
        return bundle
    }
    
    static func isEmptyTabBarItem(tabBar: UITabBarItem) -> Bool {
        return tabBar.title == nil && tabBar.image == nil && tabBar.selectedImage == nil
    }
}
