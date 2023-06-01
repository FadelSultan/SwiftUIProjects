//
//  LocalFileManager.swift
//  Crypto
//
//  Created by Fadel on 12/11/1444 AH.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    
    static let instance = LocalFileManager()
    private init() { }
    
    //MARK:- Create folder if is not exist
    private func createFolderIfNeeded(folderName:String) {
        guard let url = getUrlForFolder(folderName: folderName) else {return}
        
        if !FileManager.default.fileExists(atPath: url.path()) {
            
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            }catch let error {
                print("[🆘] There is an error when create folder: \(folderName)")
                print("The error is \(error.localizedDescription)")
            }
        }
    }
    
    
    //MARK:- Get folder path
    private func getUrlForFolder(folderName:String) -> URL? {
        
        guard let url =  FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    //MARK:- Get image path
    private func getUrlForImage(imageName:String , folderName:String) -> URL? {
        guard let url = getUrlForFolder(folderName: folderName) else {
            return nil
        }
        return url.appendingPathComponent(imageName + ".png")
    }
    
    //MARK:- Write image to file manager
    func saveImage(image:UIImage , imageName:String , folderName:String) {
        //Create folder
        createFolderIfNeeded(folderName: folderName)
        
        // get path for image
        guard
            let imageData = image.pngData(),
            let url = getUrlForImage(imageName: imageName, folderName: folderName)
        else {return }
            
          
        // save image to path
        do {
            try imageData.write(to: url)
        }catch let error {
            print("[🆘] There is an error when write image to file manager  \(error.localizedDescription) ")
        }
                
    }
    
    //MARK:- Get image from file manager
    
    func getImage(imageName:String , folderName:String) -> UIImage? {
        guard
            let url = getUrlForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path())
        else {return nil }
        
        return UIImage(contentsOfFile: url.path())
    }
}
