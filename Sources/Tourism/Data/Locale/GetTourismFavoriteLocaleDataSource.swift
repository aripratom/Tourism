//
//  File.swift
//  
//
//  Created by Aria Pratomo on 04/03/22.
//

import Combine
import RealmSwift
import Foundation
import Core
import Cleanse

public struct GetTourismFavoriteLocaleDataSource: LocaleDataSource {
    
    public typealias Request = Int
    public typealias Response = TourismModuleEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: Int?) -> AnyPublisher<[TourismModuleEntity], Error> {
        return Future<[TourismModuleEntity], Error>{ completion in
            
            let tourism: Results<TourismModuleEntity> = {
                _realm.objects(TourismModuleEntity.self)
                    .filter("favorite = \(true)")
                    .sorted(byKeyPath: "name", ascending: true)
            }()
            completion(.success(tourism.toArray(ofType: TourismModuleEntity.self)))
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [TourismModuleEntity]) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func get(id: Int) -> AnyPublisher<TourismModuleEntity, Error> {
        return Future<TourismModuleEntity, Error> { completion in
            if let tourism = { _realm.objects(TourismModuleEntity.self).filter("id = \(id)")
            }().first {
                do {
                    try _realm.write {
                        tourism.setValue(!tourism.favorite, forKey: "favorite")
                    }
                    completion(.success(tourism))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
            
        }.eraseToAnyPublisher()
    }
    
    public func update(id: Int, entity: TourismModuleEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
}

extension GetTourismFavoriteLocaleDataSource {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.bind(GetTourismFavoriteLocaleDataSource.self).to(factory: GetTourismFavoriteLocaleDataSource.init)
        }
    }
}
