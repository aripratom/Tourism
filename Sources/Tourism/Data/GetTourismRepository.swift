//
//  File.swift
//  
//
//  Created by Aria Pratomo on 01/03/22.
//

import Core
import RealmSwift
import Combine
import Cleanse

public struct GetTourismRepository<
    TourismLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
TourismLocaleDataSource.Request == Int,
TourismLocaleDataSource.Response == TourismModuleEntity,
RemoteDataSource.Request == Int,
RemoteDataSource.Response == [TourismResponse],
Transformer.Request == Int,
Transformer.Response == [TourismResponse],
Transformer.Entity == [TourismModuleEntity],
Transformer.Domain == [TourismDomainModel] {
    
    
    
    public typealias Request = Int
    public typealias Response = [TourismDomainModel]
    
    
    private let _localeDataSource: TourismLocaleDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: TourismLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
            
            _localeDataSource = localeDataSource
            _remoteDataSource = remoteDataSource
            _mapper = mapper
        }
    
    
    public func execute(request: Int?) -> AnyPublisher<[TourismDomainModel], Error> {
        if let request = request {
            return _remoteDataSource.execute(request: request)
                .map { _mapper.transformResponseToDomain(response: $0) }
                .eraseToAnyPublisher()
        } else {
            return _localeDataSource.list(request: request)
                .flatMap { result -> AnyPublisher<[TourismDomainModel], Error> in
                    if result.isEmpty {
                        return _remoteDataSource.execute(request: request)
                            .map { _mapper.transformResponseToEntity(request: request, response: $0) }
                            .flatMap { _localeDataSource.add(entities: $0) }
                            .filter { $0 }
                            .flatMap { _ in _localeDataSource.list(request: request)
                                .map { _mapper.transformEntityToDomain(entity: $0) }
                            }.eraseToAnyPublisher()
                    } else {
                        return _localeDataSource.list(request: request)
                            .map { _mapper.transformEntityToDomain(entity: $0) }
                            .eraseToAnyPublisher()
                    }
                }.eraseToAnyPublisher()
        }
    }
    

}

extension GetTourismRepository {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: GetTourismLocaleDataSource.Module.self)
            binder.include(module: GetTourismRemoteDataSource.Module.self)
            binder.include(module: TourismListTransformer.Module.self)
            binder.bind(GetTourismRepository.self).to(factory: GetTourismRepository.init)
        }
    }
}
