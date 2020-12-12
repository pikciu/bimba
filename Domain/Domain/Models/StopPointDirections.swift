import Foundation

public struct StopPointDirections {
    public let stopPoint: StopPoint
    public let directions: [Direction]
    
    public init(stopPoint: StopPoint, directions: [Direction]) {
        self.stopPoint = stopPoint
        self.directions = directions
    }
}
