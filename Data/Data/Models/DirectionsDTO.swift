import Foundation
import Domain

struct DirectionsDTO: Decodable {
    struct BollardDTO: Decodable {
        let bollard: StopPointDTO
        let directions: [DirectionDTO]
    }
    
    let bollards: [BollardDTO]
}

struct DirectionsMapper: Mapper {
    let stopPointMapper: StopPointMapper
    let directionMapper = DirectionMapper()
    
    init(useTagAsID: Bool) {
        stopPointMapper = StopPointMapper(useTagAsID: useTagAsID)
    }

    func map(from object: DirectionsDTO) -> [StopPointDirections] {
        object.bollards.map(stopPoint(bollard:))
    }
    
    private func stopPoint(bollard: DirectionsDTO.BollardDTO) -> StopPointDirections {
        StopPointDirections(
            stopPoint: stopPointMapper.map(from: bollard.bollard),
            directions: bollard.directions.map(directionMapper.map(from:))
        )
    }
}
