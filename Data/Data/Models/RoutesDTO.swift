import Foundation
import Domain

struct RoutesDTO: Decodable {
    struct RouteDTO: Decodable {
        let direction: DirectionDTO
        let bollards: [StopPointDTO]
    }
    
    let directions: [RouteDTO]
}

struct RoutesMapper: Mapper {
    let directionMapper = DirectionMapper()
    let stopPointMapper = StopPointMapper(useTagAsID: true)
    
    func map(from object: RoutesDTO) -> [Route] {
        object.directions.map(mapRoute)
    }
    
    private func mapRoute(dto: RoutesDTO.RouteDTO) -> Route {
        Route(
            direction: directionMapper.map(from: dto.direction),
            stopPoints: dto.bollards.map(stopPointMapper.map)
        )
    }
}
