//
//  PersistenceManager.swift
//  RayWenderlich
//
//  Created by Giuliano Soria Pazos on 2020-08-01.
//

import Foundation

enum PersistenceActionType { case add, remove }

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    static func retreiveItems(for key: String, completed: @escaping (Result<[Item], RWError>) -> Void) {
        guard let itemsData = defaults.object(forKey: key) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let items = try decoder.decode([Item].self, from: itemsData)
            completed(.success(items))
        } catch {
            completed(.failure(.unableToRetreiveItems))
        }
    }
    
    static func saveItems(for key: String, _ items: [Item]) -> RWError? {
        do {
            let encoder = JSONEncoder()
            let encodedItems = try encoder.encode(items)
            defaults.set(encodedItems, forKey: key)
            return nil
        } catch {
            return .unableToPersisItems
        }
    }
    
    static func updateItems(for key: String, with item: Item, actionType: PersistenceActionType, completed: @escaping (RWError?) -> Void) {
        retreiveItems(for: key) { result in
            switch result {
            case .success(var items):
                
                switch actionType {
                case .add:
                    guard !items.contains(item) else {
                        completed(.alreadyDownloaded)
                        return
                    }
                    items.append(item)
                    
                    completed(saveItems(for: key, items))
                case .remove:
                    items.removeAll { $0.attributes.name == item.attributes.name }
                    
                    completed(saveItems(for: key, items))
                }
                
                
            case .failure(let error):
                completed(error)
            }
        }
    }
}
