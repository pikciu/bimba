import Foundation
import RealmSwift
import Domain

final class FavoriteStopPointRealm: Object {
    @objc dynamic var id = ""
    
    class func create(id: String) -> FavoriteStopPointRealm {
        let object = FavoriteStopPointRealm()
        object.id = id
        return object
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
}

struct FavoriteStopPointRealmMapper: Mapper {
    func map(from object: FavoriteStopPointRealm) -> String {
        object.id
    }
}
