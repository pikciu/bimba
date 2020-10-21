import Foundation

public struct StopPointDetails {
    public struct Coordinates {
        public let latitude: Double
        public let longitude: Double
        
        public init(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
        }
    }
    public enum Route {
        case bus
        case tram
    }
    public let id: String
    public let coordinates: Coordinates
    public let name: String
    public let type: Route
    public let headsings: String
    
    public init(id: String, coordinates: Coordinates, name: String, type: Route, headsings: String) {
        self.id = id
        self.coordinates = coordinates
        self.name = name
        self.type = type
        self.headsings = headsings
    }
}
