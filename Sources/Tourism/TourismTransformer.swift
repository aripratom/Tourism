//
//  File.swift
//  
//
//  Created by Aria Pratomo on 03/03/22.
//

import Core
import Cleanse

public struct TourismTransformer : Mapper {
    
    public typealias Request = Int
    public typealias Response = TourismResponse
    public typealias Entity = TourismModuleEntity
    public typealias Domain = TourismDomainModel
    
    public init() {}
    
    public func transformResponseToEntity(request: Int?, response: TourismResponse) -> TourismModuleEntity {
          let newTourism = TourismModuleEntity()
            newTourism.id = response.id ?? 0
            newTourism.address = response.address ?? "Unkonw"
            newTourism.name = response.name ?? "Unknow"
            newTourism.image = response.image ?? "Unkonw"
            newTourism.descriptions = response.description ?? "Unknow"
            newTourism.like = response.like ?? 0
            return newTourism
    }
    
    public func transformEntityToDomain(entity: TourismModuleEntity) -> TourismDomainModel {
          return TourismDomainModel(
            id: entity.id,
            name: entity.name,
            image: entity.image,
            description: entity.descriptions,
            address: entity.address,
            like: entity.like,
            favorite: entity.favorite
          )
    }
    
    public func transformResponseToDomain(response: TourismResponse) -> TourismDomainModel {
          return TourismDomainModel(
            id: response.id ?? 0,
            name: response.name ?? "Unknow",
            image: response.image ?? "Unknow",
            description: response.description ?? "Unknow",
            address: response.address ?? "Unknow",
            like: response.like ?? 0,
            favorite: response.favorite ?? false
          )
    }
    
}

public extension TourismTransformer {
    struct Module: Cleanse.Module {
        public static func configure(binder: Binder<Singleton>) {
            binder.bind(TourismTransformer.self).to(factory: TourismTransformer.init)
        }
    }
}

