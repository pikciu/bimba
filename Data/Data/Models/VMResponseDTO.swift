import Foundation
import Domain

struct VMResponseDTO<T: Decodable>: Decodable {
    let success: T
}

struct VMResponseMapper<M: Mapper>: Mapper where M.From: Decodable {
    let mapper: M
    
    init(_ mapper: M) {
        self.mapper = mapper
    }
    
    func map(from object: VMResponseDTO<M.From>) throws -> M.To {
        try mapper.map(from: object.success)
    }
}
