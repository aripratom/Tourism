//
//  File.swift
//  
//
//  Created by Aria Pratomo on 03/03/22.
//

import Core

public typealias TourismDetailInteractor = Interactor<Int, TourismDomainModel, GetTourismDetailRepository<GetTourismLocaleDataSource, TourismTransformer>>
