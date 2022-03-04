//
//  File.swift
//  
//
//  Created by Aria Pratomo on 01/03/22.
//

import Foundation
import RealmSwift

public class TourismModuleEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var descriptions: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var like: Int = 0
    @objc dynamic var favorite: Bool = false
  
    public override static func primaryKey() -> String? {
        return "id"
    }
    
}
