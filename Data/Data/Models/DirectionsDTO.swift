import Foundation
import Domain

struct DirectionsDTO: Decodable {
    struct RouteDTO: Decodable {
        let direction: DirectionDTO
        let bollards: [StopPointDTO]
    }
    
    let directions: [RouteDTO]
}

struct DirectionsMapper: Mapper {
    let directionMapper = DirectionMapper()
    let stopPointMapper = StopPointMapper(useTagAsID: true)
    
    func map(from object: DirectionsDTO) throws -> [Route] {
        try object.directions.map(mapRoute)
    }
    
    private func mapRoute(dto: DirectionsDTO.RouteDTO) throws -> Route {
        try Route(
            direction: directionMapper.map(from: dto.direction),
            stopPoints: dto.bollards.map(stopPointMapper.map)
        )
    }
}
