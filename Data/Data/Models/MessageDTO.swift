import Foundation
import Domain

struct MessageDTO: Decodable {
}

struct MessageMapper: Mapper {

    func map(from object: MessageDTO) throws -> String {
        throw AppError.descriptive("TODO")
    }
}
