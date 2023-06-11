//
//  PortfolioDataService.swift
//  Crypto
//
//  Created by Fadel Sultan on 16/11/1444 AH.
//

import Foundation
import CoreData

class PortfolioDataService {
    private let container:NSPersistentContainer
    private let containerName:String = "PortfolioContainer"
    private let entityName:String = "PortfolioEntity"
    
    @Published var savedEntity:[PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { [weak self] _, error in
            if let error = error {
                print("[🔥] There is an error when load persistent store to container name : \(self?.containerName ?? "PortfolioContainer")")
                print("Error: \(error.localizedDescription)")
            }
            self?.getPortfolio()
        }
    }
    
    
//    MARK:- Public Functions
    
    func updatePortfolio(coin:CoinModel , amount:Double) {
        if let entity = savedEntity.first(where: {$0.coinId == coin.id}) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            }else {
                delete(entity: entity)
            }
        }else {
            add(coin: coin, amount: amount)
        }
    }
    
    
//    MARK:- Private Functions
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        
        do {
            savedEntity = try container.viewContext.fetch(request)
        }catch let error {
            print("[🔥] There is an error when fetch data from entity: \(entityName)")
            print("Error: \(error.localizedDescription)")
        }
    }
    
    private func add(coin:CoinModel , amount:Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinId = coin.id
        entity.amount = amount
        
        applyChanges()
    }
    
    private func update(entity:PortfolioEntity , amount:Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity:PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do{
            try container.viewContext.save()
        }catch let error {
            print("[🔥] There is an error when save entity -> \(error.localizedDescription)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
