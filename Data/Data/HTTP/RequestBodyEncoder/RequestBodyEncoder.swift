import Foundation

protocol RequestBodyEncoder {
    func encode<T: Encodable>(_ value: T) throws -> Data
}
