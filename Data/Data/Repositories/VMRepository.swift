import Foundation
import Domain
import RxSwift

struct VMRepository: Domain.VMRepository {
    func times(stopPointID: String) -> Single<[DepartureTime]> {
        APIClient().execute(
            request: StopPointRequest(stopPointID: stopPointID, method: .times),
            responseMapper: VMResponseMapper(DepartureTimesMapper())
        )
    }
    
    func searchLines(query: String) -> Single<[String]> {
        APIClient().execute(
            request: SearchRequest(method: .lines, query: query),
            responseMapper: VMResponseMapper(ArrayMapper(LineMapper()))
        )
    }
    
    func searchStreets(query: String) -> Single<[Street]> {
        APIClient().execute(
            request: SearchRequest(method: .streets, query: query),
            responseMapper: VMResponseMapper(ArrayMapper(StreetMapper()))
        )
    }
    
    func searchStopPoints(query: String) -> Single<[StopPointGroup]> {
        APIClient().execute(
            request: SearchRequest(method: .stopPoints, query: query),
            responseMapper: VMResponseMapper(ArrayMapper(StopPointGroupMapper()))
        )
    }
    
    func routes(for line: String) -> Single<[Route]> {
        APIClient().execute(
            request: NameRequest(name: line, method: .directionsByLine),
            responseMapper: VMResponseMapper(RoutesMapper())
        )
    }
    
    func stopPoints(street: String) -> Single<[StopPointDirections]> {
        APIClient().execute(
            request: NameRequest(name: street, method: .stopPointsByStreet),
            responseMapper: VMResponseMapper(DirectionsMapper(useTagAsID: false))
        )
    }
    
    func stopPoints(name stopPoint: String) -> Single<[StopPointDirections]> {
        APIClient().execute(
            request: NameRequest(name: stopPoint, method: .stopPointsByName),
            responseMapper: VMResponseMapper(DirectionsMapper(useTagAsID: true))
        )
    }
    
    func message(stopPointID: String) -> Single<String> {
        APIClient().execute(
            request: StopPointRequest(stopPointID: stopPointID, method: .message),
            responseMapper: VMResponseMapper(MessageMapper())
        )
    }
}
