import Foundation
import Domain

struct DepartureTimesDTO: Decodable {
    struct DepartureTimeDTO: Decodable {
        let direction: String
        let line: String
        let minutes: Int
        let onStopPoint: Bool
        let realTime: Bool
        let departure: String
    }
    
    let times: [DepartureTimeDTO]
}

struct DepartureTimesMapper: Mapper {
    private let dateTimeMapper = DateTimeMapper()
    
    func map(from object: DepartureTimesDTO) throws -> [DepartureTime] {
        try object.times.map(mapTime)
    }
    
    private func mapTime(from dto: DepartureTimesDTO.DepartureTimeDTO) throws -> DepartureTime {
        let departure = try dateTimeMapper.map(from: dto.departure)
        return DepartureTime(
            departure: departure,
            direction: dto.direction,
            line: dto.line,
            minutesToDeparture: dto.minutes,
            isOnStopPoint: dto.onStopPoint,
            isRealTime: dto.realTime
        )
    }
}
