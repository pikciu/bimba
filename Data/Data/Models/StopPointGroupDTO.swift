import Foundation
import Domain

struct StopPointGroupDTO: Decodable {
    let symbol: String
    let name: String
}

struct StopPointGroupMapper: Mapper {
    
    func map(from object: StopPointGroupDTO) throws -> StopPointGroup {
        StopPointGroup(id: object.symbol, name: object.name)
    }
}
