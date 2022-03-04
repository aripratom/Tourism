import Core
import Cleanse

public struct TourismListTransformer : Mapper {
    

    public typealias Request = Int
    public typealias Response = [TourismResponse]
    public typealias Entity = [TourismModuleEntity]
    public typealias Domain = [TourismDomainModel]
    
    public init() {}
    
    public func transformResponseToEntity(request: Int?, response: [TourismResponse]) -> [TourismModuleEntity] {
        return response.map { result in
          let newTourism = TourismModuleEntity()
            newTourism.id = result.id ?? 0
            newTourism.address = result.address ?? "Unkonw"
            newTourism.name = result.name ?? "Unknow"
            newTourism.image = result.image ?? "Unkonw"
            newTourism.descriptions = result.description ?? "Unknow"
            newTourism.like = result.like ?? 0
            return newTourism
        }
    }
    
    public func transformEntityToDomain(entity: [TourismModuleEntity]) -> [TourismDomainModel] {
        return entity.map { result in
          return TourismDomainModel(
            id: result.id,
            name: result.name,
            image: result.image,
            description: result.descriptions,
            address: result.address,
            like: result.like,
            favorite: result.favorite
          )
        }
    }
    
    public func transformResponseToDomain(response: [TourismResponse]) -> [TourismDomainModel] {
        return response.map { result in
          return TourismDomainModel(
            id: result.id ?? 0,
            name: result.name ?? "Unknow",
            image: result.image ?? "Unknow",
            description: result.description ?? "Unknow",
            address: result.address ?? "Unknow",
            like: result.like ?? 0,
            favorite: result.favorite ?? false
          )
        }
    }
    
}

public extension TourismListTransformer {
    struct Module: Cleanse.Module {
        public static func configure(binder: Binder<Singleton>) {
            binder.bind(TourismListTransformer.self).to(factory: TourismListTransformer.init)
        }
    }
}
