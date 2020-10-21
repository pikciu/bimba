import Foundation

public struct Route {
    public struct Direction {
        public let name: String
        public let line: String
        
        public init(name: String, line: String) {
            self.name = name
            self.line = line
        }
    }
    
    public let direction: Direction
    public let stopPoints: [StopPoint]
    
    public init(direction: Direction, stopPoints: [StopPoint]) {
        self.direction = direction
        self.stopPoints = stopPoints
    }
}
