import Foundation
import Domain

struct StopPointDTO: Decodable {
    let symbol: String
    let tag: String
    let name: String
}

struct StopPointMapper: Mapper {
    private let nameMapper = StopPointNameMapper()
    
    let useTagAsID: Bool
    
    func map(from object: StopPointDTO) -> StopPoint {
        StopPoint(
            id: id(from: object),
            name: nameMapper.map(from: object.name)
        )
    }
    
    private func id(from dto: StopPointDTO) -> String {
        if useTagAsID {
            return dto.tag
        }
        return dto.symbol
    }
}

struct StopPointNameMapper: Mapper {
    let pattern = " - \\d+$"
    
    func map(from object: String) -> String {
        let range = object.startIndex..<object.endIndex
        
        return object.replacingOccurrences(
            of: pattern,
            with: "",
            options: .regularExpression,
            range: range
        )
    }
}
