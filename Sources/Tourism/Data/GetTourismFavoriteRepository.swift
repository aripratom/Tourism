//
//  File.swift
//  
//
//  Created by Aria Pratomo on 04/03/22.
//

import Core
import Combine
import Cleanse

public struct GetTourismFavoriteRepository<
    TourismLocaleDataSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
TourismLocaleDataSource.Request == Int,
TourismLocaleDataSource.Response == TourismModuleEntity,
Transformer.Request == Int,
Transformer.Response == [TourismResponse],
Transformer.Entity == [TourismModuleEntity],
Transformer.Domain == [TourismDomainModel] {
    
    public typealias Request = Int
    public typealias Response = [TourismDomainModel]
    
    private let _localDataSource: TourismLocaleDataSource
    private let _mapper: Transformer
    
    public init(
        localDataSource: TourismLocaleDataSource,
        mapper: Transformer
    ) {
        _localDataSource = localDataSource
        _mapper = mapper
    }
    
    public func execute(request: Int?) -> AnyPublisher<[TourismDomainModel], Error> {
        return _localDataSource.list(request: request)
            .map{ _mapper.transformEntityToDomain(entity: $0)}
            .eraseToAnyPublisher()
    }
}

public extension GetTourismFavoriteRepository {
    struct Module: Cleanse.Module {
        public static func configure(binder: Binder<Singleton>) {
            binder.bind(GetTourismFavoriteRepository.self).to(factory: GetTourismFavoriteRepository.init)
        }
    }
}
