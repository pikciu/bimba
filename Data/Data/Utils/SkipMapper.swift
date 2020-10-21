import Foundation
import Domain

struct SkipMapper<T>: Mapper {
    
    func map(from object: T) throws -> T {
        object
    }
}
