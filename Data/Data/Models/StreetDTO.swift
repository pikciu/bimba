import Foundation
import Domain

struct StreetDTO: Decodable {
    let id: Int
    let name: String
}

struct StreetMapper: Mapper {
    
    func map(from object: StreetDTO) -> Street {
        Street(id: object.id, name: object.name)
    }
}
