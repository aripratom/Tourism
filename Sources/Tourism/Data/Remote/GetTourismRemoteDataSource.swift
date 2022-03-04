//
//  File.swift
//  
//
//  Created by Aria Pratomo on 01/03/22.
//

import Foundation
import Core
import Alamofire
import Cleanse
import Combine


public struct GetTourismRemoteDataSource : DataSource {
    public typealias Request = Int
    
    public typealias Response = [TourismResponse]

    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        return Future<[TourismResponse], Error> { completion in
            
            if let url = URL(string: API.baseUrl) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: TourismsResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.places))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}

extension GetTourismRemoteDataSource {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.bind(GetTourismRemoteDataSource.self).to(factory: GetTourismRemoteDataSource.init)
        }
    }
}
