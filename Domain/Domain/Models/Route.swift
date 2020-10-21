import Foundation

public struct Route {
    public let direction: Direction
    public let stopPoints: [StopPoint]
    
    public init(direction: Direction, stopPoints: [StopPoint]) {
        self.direction = direction
        self.stopPoints = stopPoints
    }
}
