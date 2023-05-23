//
//  PhotoModel.swift
//  SwiftUIListThree
//
//  Created by Fadel on 01/11/1444 AH.
//

import Foundation


struct PhotoModel:Identifiable , Codable {
    let albumId:Int
    let id:Int
    let title:String
    let url:String
    let thumbnailUrl:String
}
