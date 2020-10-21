import Foundation
import Domain

struct LineDTO: Decodable {
    let name: String
}

struct LineMapper: Mapper {
    func map(from object: LineDTO) throws -> String {
        object.name
    }
}
