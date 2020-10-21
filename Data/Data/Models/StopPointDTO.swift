import Foundation
import Domain

struct StopPointDTO: Decodable {
    let symbol: String
    let tag: String
    let name: String
}

struct StopPointMapper: Mapper {
    
    let useTagAsID: Bool
    
    func map(from object: StopPointDTO) throws -> StopPoint {
        StopPoint(id: id(from: object), name: object.name)
    }
    
    private func id(from dto: StopPointDTO) -> String {
        if useTagAsID {
            return dto.tag
        }
        return dto.symbol
    }
}
