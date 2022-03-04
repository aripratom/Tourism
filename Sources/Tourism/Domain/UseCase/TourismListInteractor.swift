//
//  File.swift
//  
//
//  Created by Aria Pratomo on 03/03/22.
//

import Core

public typealias TourismListInteractor = Interactor<Int, [TourismDomainModel], GetTourismRepository<GetTourismLocaleDataSource, GetTourismRemoteDataSource, TourismListTransformer>>

