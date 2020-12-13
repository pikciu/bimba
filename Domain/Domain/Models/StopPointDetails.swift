import Foundation

public struct StopPointDetails: StopPointType, Equatable {
    public struct Coordinates: Hashable {
        public let latitude: Double
        public let longitude: Double
        
        public init(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
        }
    }
    
    public enum Route: Comparable {
        case tram(String)
        case bus(String)
        
        public var headsings: String {
            switch self {
            case .bus(let headsings):
                return headsings
            case .tram(let headsings):
                return headsings
            }
        }
        
        
    }
    public let id: String
    public let coordinates: Coordinates
    public let name: String
    public let type: [Route]
    
    public var headsings: String {
        type.map({ $0.headsings }).joined(separator: ", ")
    }
    
    public init(id: String, coordinates: Coordinates, name: String, type: [Route]) {
        self.id = id
        self.coordinates = coordinates
        self.name = name
        self.type = type
    }
}
