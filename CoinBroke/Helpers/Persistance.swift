//
//  Persistance.swift
//  CoinBroke
//
//  Created by vlad on 20.05.2022.
//

import Foundation
import RealmSwift

protocol DataPersistable {
    func getHistory(forCoinWithCode code: String) -> Result<[StoredCoin], PersistanceEror>
    func getLastValue(ofWithCode code: String) -> Result<StoredCoin, PersistanceEror>
    func getUpdates(forCoinWithCode code: String, forLast seconds: Int) -> Result<[StoredCoin], PersistanceEror>
    func save(coin: StoredCoin) -> PersistanceEror?
}

class StoredCoin: Object {
    @Persisted var name: String = ""
    @Persisted var code: String = ""
    @Persisted var price: Double = 0.0
    @Persisted var imageUrl: String?
    @Persisted var createdAt: Date? = Date()
}

enum PersistanceEror: Error {
    case noData
    case instantiationError
    case sourceInitializationError(error: Error)
    case writeError(error: Error)
}

class RealmPersistance: DataPersistable {
  
    var realm: Realm?
    
    init() {
        do {
            realm = try Realm()
        }
        catch(let error) {
            print("ooops, it didnt instansiate, error: \(error)")
        }
    }
  
    
    // Data Persistable
    func getHistory(forCoinWithCode code: String) -> Result<[StoredCoin], PersistanceEror> {
        guard let realm = realm else { return .failure(.instantiationError) }
        
        let coins = realm.objects(StoredCoin.self)
        let coinsWithCode = coins.where {
            $0.code == code
        }
        
        return .success(Array(coinsWithCode))
    }
    
    func getLastValue(ofWithCode code: String) -> Result<StoredCoin, PersistanceEror> {
        let result = self.getHistory(forCoinWithCode: code)
        switch result {
        case .success(let storedCoins):
            guard let lastUpdate = storedCoins.last else { return .failure(.noData) }
            return .success(lastUpdate)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func getUpdates(forCoinWithCode code: String, forLast seconds: Int) -> Result<[StoredCoin], PersistanceEror> {
        let result = self.getHistory(forCoinWithCode: code)
        guard case .success(let lastUpdates) = result else { return result }
        
        let updatesForLast = lastUpdates.filter { coin in
            guard let createdAt = coin.createdAt else { return false }
            return createdAt.timeIntervalSince1970 > Date().timeIntervalSince1970 - Double(seconds)
        }
        
        return .success(updatesForLast)
    }
    
    func save(coin: StoredCoin) -> PersistanceEror? {
        guard let realm = realm else { return .instantiationError }

        do {
            try realm.write {
                realm.add(coin)
            }
            return nil
        }
        catch(let error) {
            return .writeError(error: error)
        }
    }
}
