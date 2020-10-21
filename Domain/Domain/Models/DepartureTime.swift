import Foundation

public struct DepartureTime {
    public let departure: Date
    public let direction: String
    public let line: String
    public let minutesToDeparture: Int
    public let isOnStopPoint: Bool
    public let isRealTime: Bool
    
    public init(
        departure: Date,
        direction: String,
        line: String,
        minutesToDeparture: Int,
        isOnStopPoint: Bool,
        isRealTime: Bool
    ) {
        self.departure = departure
        self.direction = direction
        self.line = line
        self.minutesToDeparture = minutesToDeparture
        self.isOnStopPoint = isOnStopPoint
        self.isRealTime = isRealTime
    }
}
