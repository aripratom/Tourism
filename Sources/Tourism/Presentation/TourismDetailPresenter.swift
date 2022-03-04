//
//  File.swift
//  
//
//  Created by Aria Pratomo on 03/03/22.
//

import Core
import Cleanse


public typealias TourismDetailPresenter = GetDetailPresenter<Int, TourismDomainModel, TourismDetailInteractor>

public extension TourismDetailPresenter {
    struct AssistedFeed: AssistedFactory {
        public typealias Seed = TourismDomainModel
        public typealias Element = TourismDetailPresenter
    }
}
