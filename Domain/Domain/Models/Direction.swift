import Foundation

public protocol DirectionType {
    var name: String { get }
    var line: String { get }
}

public struct Direction: DirectionType, Equatable {
    
    public let name: String
    public let line: String
    
    public init(name: String, line: String) {
        self.name = name
        self.line = line
    }
}
