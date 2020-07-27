//
//  BaseRepository.swift
//  App
//
//  Created by Sheikh Ahmed on 26/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import Foundation


//MARK: - BaseRepository
class BaseRepository<T> {
    
    //MARK: - Stored Properties
    var dbManager : DataBaseManager
    
    //MARK: - Init
    required init(dbManager : DataBaseManager) {
        self.dbManager = dbManager
    }
    
    //MARK: - Methods
    func fetch<T>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: (([T]) -> ())) where T : Storable {
        dbManager.fetch(model, predicate: predicate, sorted: sorted, completion: completion)
    }
//    
    func deleteAll<T>(_ model: T.Type) throws where T : Storable {
        try dbManager.deleteAll(model)
    }
    
//    func delete(object: Storable) throws {
//        try dbManager.delete(object: object)
//    }
    
//    func update(object: Storable) throws {
//
//        try dbManager.update(object: object)
//    }
    func save(object: Storable) throws {
        try dbManager.save(object: object)
    }
    
    
}
