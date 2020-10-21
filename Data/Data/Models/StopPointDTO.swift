import Foundation
import Domain

struct StopPointDTO: Decodable {
    let symbol: String
    let name: String
}

struct StopPointMapper: Mapper {
    
    func map(from object: StopPointDTO) throws -> StopPoint {
        StopPoint(id: object.symbol, name: object.name)
    }
}
