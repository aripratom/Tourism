//
//  File.swift
//  
//
//  Created by Aria Pratomo on 01/03/22.
//

import Combine
import RealmSwift
import Foundation
import Core
import Cleanse


public struct GetTourismLocaleDataSource: LocaleDataSource {
    
    public typealias Request = Int
    public typealias Response = TourismModuleEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    
    public func list(request: Int?) -> AnyPublisher<[TourismModuleEntity], Error> {
        return Future<[TourismModuleEntity], Error>{ completion in
            
            let tourism: Results<TourismModuleEntity> = {
                _realm.objects(TourismModuleEntity.self).sorted(byKeyPath: "name", ascending: true)
            }()
            completion(.success(tourism.toArray(ofType: TourismModuleEntity.self)))
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [TourismModuleEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    for tourism in entities {
                        _realm.add(tourism, update: .all)
                        completion(.success(true))
                    }
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    public func get(id: Int) -> AnyPublisher<TourismModuleEntity, Error> {
        return Future<TourismModuleEntity, Error> { completion in
            let tourism: Results<TourismModuleEntity> = {
                _realm.objects(TourismModuleEntity.self)
                    .filter("id = \(id)")
            }()
            
            guard let tourism = tourism.first else {
                completion(.failure(DatabaseError.requestFailed))
                return
            }
            
            completion(.success(tourism))
            
        }.eraseToAnyPublisher()
    }
    
    public func update(id: Int, entity: TourismModuleEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let tourismEntity = {
                _realm.objects(TourismModuleEntity.self).filter("id = \(id)")
            }().first {
                do {
                    try _realm.write{
                        tourismEntity.setValue(entity.id, forKey: "id")
                        tourismEntity.setValue(entity.name, forKey: "name")
                        tourismEntity.setValue(entity.image, forKey: "image")
                        tourismEntity.setValue(entity.descriptions, forKey: "descriptions")
                        tourismEntity.setValue(entity.address, forKey: "address")
                        tourismEntity.setValue(entity.like, forKey: "like")
                        tourismEntity.setValue(entity.favorite, forKey: "favorite")
                    }
                    completion(.success(true))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
}

extension GetTourismLocaleDataSource {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: Realm.Module.self)
            binder.bind(GetTourismLocaleDataSource.self).to(factory: GetTourismLocaleDataSource.init)
        }
    }
}

