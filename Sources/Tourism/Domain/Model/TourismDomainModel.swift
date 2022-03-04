//
//  File.swift
//  
//
//  Created by Aria Pratomo on 01/03/22.
//

import Foundation

public struct TourismDomainModel: Equatable, Identifiable {

    public let id: Int
    public let name: String
    public let image: String
    public let description: String
    public let address: String
    public let like: Int
    public var favorite: Bool
  
}
