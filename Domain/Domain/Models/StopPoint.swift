import Foundation

public struct StopPoint: StopPointType, Equatable {
    public let id: String
    public let name: String
    
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

public protocol StopPointType {
    var id: String { get }
    var name: String { get }
}
