import Foundation
import Domain

struct DirectionDTO: Decodable {
    let lineName: String
    let direction: String
}

struct DirectionMapper: Mapper {
    
    func map(from object: DirectionDTO) throws -> Direction {
        Direction(
            name: object.direction,
            line: object.lineName
        )
    }
}
