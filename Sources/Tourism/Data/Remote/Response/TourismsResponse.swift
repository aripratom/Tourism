//
//  File.swift
//  
//
//  Created by Aria Pratomo on 01/03/22.
//

import Foundation

struct TourismsResponse: Decodable {
  let places: [TourismResponse]
}

public struct TourismResponse: Decodable {
    
    let id: Int?
    let name: String?
    let image: String?
    let description: String?
    let address: String?
    let like: Int?
    let favorite: Bool?

}
