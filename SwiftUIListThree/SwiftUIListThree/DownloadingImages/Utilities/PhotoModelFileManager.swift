//
//  PhotoModelFileManager.swift
//  SwiftUIListThree
//
//  Created by Fadel on 02/11/1444 AH.
//

import Foundation
import SwiftUI

class PhotoModelFileManager {
    static let instance = PhotoModelFileManager()
    
    private let folderName = "downloaded_folder"
    
    private init() {
        createFolderIfNeeded()
    }
    
    private func createFolderIfNeeded(){
        guard let url = getFolderPath() else {return}
        if !FileManager.default.fileExists(atPath: url.path()) {
            
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
                print("Created folder!")
            }catch let error {
                print("There is an error when create folder: \(error.localizedDescription)")
            }
        }
    }
    
    private func getImagePath(key:String) -> URL? {
        guard let folder = getFolderPath() else {return nil}
        
        return folder.appendingPathComponent(key + ".png")
    }
    
    private func getFolderPath() -> URL? {
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    }
    
    func add(key:String , image:UIImage) {
        guard let data = image.pngData() ,
              let url = getImagePath(key: key) else {return}
        
        do {
            try data.write(to: url)
        }catch let error {
            print("There is an error when write image: \(error)")
        }
    }
    
    func get(key:String) -> UIImage? {
        guard
            let url = getImagePath(key: key),
            FileManager.default.fileExists(atPath: url.path())
        else {return nil}
        
        return UIImage(contentsOfFile: url.path())
    }
    
}
