//
//  PhotoModelCacheManager.swift
//  SwiftUIListThree
//
//  Created by Fadel on 01/11/1444 AH.
//

import Foundation
import SwiftUI

class PhotoModelCacheManager {
    
    static let instance = PhotoModelCacheManager()
    
    private init(){}
    
    private var photoCache:NSCache<NSString, UIImage> = {
       var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 2024 * 2024 * 200
        return cache
    }()
    
    func add(key:String , value:UIImage) {
        photoCache.setObject(value, forKey: key as NSString)
    }
    
    func get(key:String) -> UIImage? {
        return photoCache.object(forKey: key as NSString)
    }
}
