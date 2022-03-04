//
//  File.swift
//  
//
//  Created by Aria Pratomo on 03/03/22.
//

import Cleanse
import Core

public extension GetListPresenter {
    struct Module: Cleanse.Module {
        public static func configure(binder: Binder<Singleton>) {
            
            binder.include(module: GetTourismRepository<
                            GetTourismLocaleDataSource,
                            GetTourismRemoteDataSource,
                            TourismListTransformer>.Module.self)
            
            binder.include(module: GetTourismFavoriteRepository<
                            GetTourismFavoriteLocaleDataSource,
                            TourismListTransformer>.Module.self)
            
            binder.bind(TourismListPresenter.self).to{(tourismListRepository: Provider<GetTourismRepository<GetTourismLocaleDataSource, GetTourismRemoteDataSource, TourismListTransformer>>) ->
                TourismListPresenter in
                return TourismListPresenter(useCase: TourismListInteractor(repository: tourismListRepository.get()))
            }
            
            binder.bind(TourismListFavoritePresenter.self).to{ (favoriteTourismRepository: Provider<GetTourismFavoriteRepository<GetTourismFavoriteLocaleDataSource, TourismListTransformer>>) ->
                TourismListFavoritePresenter in
                return TourismListFavoritePresenter(useCase: TourismListFavoriteInteractor(repository: favoriteTourismRepository.get()))
            }
            
            
        }
    }
}

public extension GetDetailPresenter {
    struct Module: Cleanse.Module {
        public static func configure(binder: Binder<Singleton>) {
            
            binder.include(module: GetTourismDetailRepository<
                            GetTourismLocaleDataSource,
                            TourismTransformer>.Module.self)
            
            binder.include(module: GetTourismUpdateFavoriteRepository<
                            GetTourismFavoriteLocaleDataSource,
                            TourismTransformer>.Module.self)
            
            
            binder.bindFactory(TourismDetailPresenter.self).with(TourismDetailPresenter.AssistedFeed.self).to { (detailRepository: Provider<GetTourismDetailRepository<GetTourismLocaleDataSource, TourismTransformer>>, seed: Assisted<TourismDomainModel>) ->
                TourismDetailPresenter in
                return TourismDetailPresenter(useCase: TourismDetailInteractor(repository: detailRepository.get()), request: seed.get().id)
            }
            
            binder.bind(TourismUpdatePresenter.self).to{ (updateRepository: Provider<GetTourismUpdateFavoriteRepository<GetTourismFavoriteLocaleDataSource, TourismTransformer>>) ->
                TourismUpdatePresenter in
                return TourismUpdatePresenter(useCase: TourismUpdateInteractor(repository: updateRepository.get()))
            }
            
        }
    }
}

