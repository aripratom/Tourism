//
//  File.swift
//  
//
//  Created by Aria Pratomo on 04/03/22.
//

import Core

public typealias TourismListFavoriteInteractor = Interactor<Int, [TourismDomainModel], GetTourismFavoriteRepository<GetTourismFavoriteLocaleDataSource, TourismListTransformer>>
