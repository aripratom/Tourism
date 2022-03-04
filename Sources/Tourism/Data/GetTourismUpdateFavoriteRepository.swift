//
//  File.swift
//  
//
//  Created by Aria Pratomo on 04/03/22.
//

import Core
import Combine
import Cleanse

public struct GetTourismUpdateFavoriteRepository<
    TourismLocaleDataSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
TourismLocaleDataSource.Request == Int,
TourismLocaleDataSource.Response == TourismModuleEntity,
Transformer.Request == Int,
Transformer.Response == TourismResponse,
Transformer.Entity == TourismModuleEntity,
Transformer.Domain == TourismDomainModel {
    
    public typealias Request = Int
    public typealias Response = TourismDomainModel
    
    private let _localeDataSource: TourismLocaleDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: TourismLocaleDataSource,
        mapper: Transformer) {
            
            _localeDataSource = localeDataSource
            _mapper = mapper
        }
    
    public func execute(request: Int?) -> AnyPublisher<TourismDomainModel, Error> {
        return _localeDataSource.get(id: request ?? 0)
            .map{_mapper.transformEntityToDomain(entity: $0)}
            .eraseToAnyPublisher()
    }
}

extension GetTourismUpdateFavoriteRepository {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: GetTourismFavoriteLocaleDataSource.Module.self)
            binder.bind(GetTourismUpdateFavoriteRepository.self).to(factory: GetTourismUpdateFavoriteRepository.init)
        }
    }
}
