//
//  DownloadingImagesViewModel.swift
//  SwiftUIListThree
//
//  Created by Fadel on 01/11/1444 AH.
//

import Foundation
import Combine

class DownloadingImagesViewModel:ObservableObject {
    
    @Published var dataArray:[PhotoModel] = []
    
    private var cancelable = Set<AnyCancellable>()
    private let manager = PhotoModelDataService.instance
    
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        manager.$dataList
            .sink { [weak self] returnedData in
                self?.dataArray = returnedData
            }
            .store(in: &cancelable)
    }
    
    
}
