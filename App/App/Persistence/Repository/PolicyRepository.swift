//
//  PolicyRepository.swift
//  App
//
//  Created by Sheikh Ahmed on 26/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import Foundation
import RealmSwift


//MARK: -  PolicyRepositoryProtocol
protocol PolicyRepositoryProtocol {
    
    //MARK: - Methods
    func getAllPolicies(on sort: Sorted?, completionHandler: ([PolicyEventModel]) -> Void)
    func savePolicy(policy: PolicyEventModel)
}

//MARK: -  PolicyRepository
class PolicyRepository : BaseRepository<PolicyDTO> {
    
}

//MARK: -  UserRepositoryProtocol implementation
extension PolicyRepository: PolicyRepositoryProtocol {
    
    //MARK: - Methods
    func getAllPolicies(on sort: Sorted? = nil, completionHandler: ([PolicyEventModel]) -> Void){
        super.fetch(PolicyDTO.self, predicate: nil, sorted: nil) { (policies) in
            completionHandler(policies.map { PolicyEventModel.mapFromPersistenceObject($0)} )
        }
    }
    func savePolicy(policy: PolicyEventModel){
        do { try super.save(object: policy.mapToPersistenceObject()) }
        catch { print(error.localizedDescription) }
    }
    func deleteAllPolicies(){
        do { try super.deleteAll(PolicyDTO.self)}
        catch {print(error.localizedDescription)}
    }
   
}



class RealmDataBaseManager: DataBaseManager {
    
 
    //MARK: - Stored Properties
    private let realm: Realm?
    
    init(_ realm: Realm? = try! Realm()) {
        self.realm = realm
    }
    
    func save(object: Storable) throws {
        guard let realm = realm, let object = object as? Object else { throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel }
        try realm.write {
            realm.add(object)
        }
    }
    
    func deleteAll<T>(_ model: T.Type) throws where T : Storable {
        guard let realm = realm, let model = model as? Object.Type else {throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel}
        try realm.write {
            let objects = realm.objects(model)
            for object in objects {
                realm.delete(object)
            }
        }
    }
    func fetch<T>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: (([T]) -> ())) where T : Storable {
        guard let realm = realm, let model = model as? Object.Type else {return}
        let objects = realm.objects(model)
        completion(objects.compactMap {$0 as? T})
    }
}
protocol DataBaseManager {
    func save(object: Storable) throws
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: (([T]) -> ()))
    func deleteAll<T: Storable>(_ model: T.Type) throws
}
