//
//  ImageLodingViewModel.swift
//  SwiftUIListThree
//
//  Created by Fadel on 01/11/1444 AH.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel:ObservableObject {
    
    @Published var image:UIImage? = nil
    @Published var isLoading:Bool = false
    
    private var cancellable = Set<AnyCancellable>()
    private let manager = PhotoModelFileManager.instance
    
    let urlString:String
    let imageKey:String
    
    
    init(url:String , key:String) {
        urlString = url
        imageKey = key
        getImage()
    }
    
    private func getImage() {
        if let image = manager.get(key: imageKey) {
            self.image = image
            print("Get image from cache memory ")
        }else {
            downloadImage()
            print("Download image")
        }
    }
    
    private func downloadImage() {
        isLoading = true
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map {UIImage(data: $0.data)}
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedPhoto in
                guard
                    let photo = returnedPhoto ,
                    let self = self
                else {return}
                
                self.image = photo
                self.manager.add(key: self.imageKey, image: photo)
            }
            .store(in: &cancellable)

    }
}
