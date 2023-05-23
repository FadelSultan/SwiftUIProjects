//
//  PhotoModelDataService.swift
//  SwiftUIListThree
//
//  Created by Fadel on 01/11/1444 AH.
//

import Foundation
import Combine

class PhotoModelDataService {
    
    static let instance = PhotoModelDataService()
    
    @Published var dataList:[PhotoModel] = []
    
    private var cancellable = Set<AnyCancellable>()
    
    private init() {
        downloadData()
    }
    
    private func downloadData() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {return}
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { compilation in
                switch compilation {
                case .failure(let error):
                    print("There is an error when download data: \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] returnedData in
                self?.dataList = returnedData
            }
            .store(in: &cancellable)

    }
    
    private func handleOutput(output:URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse ,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
            
        }
        
        return output.data
              
    }
}
