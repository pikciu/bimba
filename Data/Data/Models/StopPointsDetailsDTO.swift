import Foundation
import Domain

struct StopPointsDetailsDTO: Decodable {
    struct StopPointDetailsDTO: Decodable {
        struct GeometryDTO: Decodable {
            let coordinates: [Double]
        }
        
        struct PropertiesDTO: Decodable {
            enum RouteTypeDTO: String, Decodable {
                case tram = "0"
                case bus = "3"
            }
            let headsigns: String
            let routeType: RouteTypeDTO
            let name: String
            
            enum CodingKeys: String, CodingKey {
                case headsigns
                case routeType = "route_type"
                case name = "stop_name"
            }
        }
        
        let id: String
        let geometry: GeometryDTO
        let properties: PropertiesDTO
    }
    
    let features: [StopPointDetailsDTO]
}

struct StopPointsDetailsMapper: Mapper {
    
    func map(from object: StopPointsDetailsDTO) throws -> [StopPointDetails] {
        try object.features.map(mapStopPoint)
    }
    
    private func mapStopPoint(from dto: StopPointsDetailsDTO.StopPointDetailsDTO) throws -> StopPointDetails {
        guard
            dto.geometry.coordinates.count == 2
        else {
            throw AppError.mappingError(AppError.descriptive("Invalid stop point coordinates"))
        }
        let longitude = dto.geometry.coordinates[0]
        let latitude = dto.geometry.coordinates[1]
        return StopPointDetails(
            id: dto.id,
            coordinates: StopPointDetails.Coordinates(
                latitude: latitude,
                longitude: longitude
            ),
            name: dto.properties.name,
            type: [route(dto: dto)]
        )
    }
    
    private func route(dto: StopPointsDetailsDTO.StopPointDetailsDTO) -> StopPointDetails.Route {
        switch dto.properties.routeType {
        case .bus:
            return .bus(dto.properties.headsigns)
        case .tram:
            return .tram(dto.properties.headsigns)
        }
    }
}
