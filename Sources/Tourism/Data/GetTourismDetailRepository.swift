//
//  File.swift
//  
//
//  Created by Aria Pratomo on 03/03/22.
//

import Core
import Combine
import Cleanse

public struct GetTourismDetailRepository<TourismLocaleDataSource: LocaleDataSource, Transformer: Mapper>: Repository
where
TourismLocaleDataSource.Request == Int,
TourismLocaleDataSource.Response == TourismModuleEntity,
Transformer.Request == Int,
Transformer.Response == TourismResponse,
Transformer.Entity == TourismModuleEntity,
Transformer.Domain == TourismDomainModel {
    
    
    public typealias Request = Int
    public typealias Response = TourismDomainModel
    
    private let _localDataSource: TourismLocaleDataSource
    private let _mapper: Transformer
    
    public init(
        localDataSource: TourismLocaleDataSource,
        mapper: Transformer
    ) {
        _localDataSource = localDataSource
        _mapper = mapper
    }
    
    public func execute(request: Int?) -> AnyPublisher<TourismDomainModel, Error> {
        guard let request = request else {
            fatalError("Request cannot be empty")
        }
        
        return _localDataSource.get(id: request)
            .map {
                _mapper.transformEntityToDomain(entity: $0)
            }.eraseToAnyPublisher()
        
    }
    
    
}

public extension GetTourismDetailRepository {
    struct Module: Cleanse.Module {
        public static func configure(binder: Binder<Singleton>) {
            binder.include(module: GetTourismLocaleDataSource.Module.self)
            binder.include(module: TourismTransformer.Module.self)
            binder.bind(GetTourismDetailRepository.self).to(factory: GetTourismDetailRepository.init)
        }
    }
}

