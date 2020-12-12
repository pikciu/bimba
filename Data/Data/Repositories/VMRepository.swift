import Foundation
import Domain
import RxSwift

struct VMRepository: Domain.VMRepository {
    func times(stopPointID: String) -> Observable<[DepartureTime]> {
        APIClient().execute(
            request: StopPointRequest(stopPointID: stopPointID, method: .times),
            responseMapper: VMResponseMapper(DepartureTimesMapper())
        )
    }
    
    func searchLines(query: String) -> Observable<[String]> {
        APIClient().execute(
            request: SearchRequest(method: .lines, query: query),
            responseMapper: VMResponseMapper(ArrayMapper(LineMapper()))
        )
    }
    
    func searchStreets(query: String) -> Observable<[Street]> {
        APIClient().execute(
            request: SearchRequest(method: .streets, query: query),
            responseMapper: VMResponseMapper(ArrayMapper(StreetMapper()))
        )
    }
    
    func searchStopPoints(query: String) -> Observable<[StopPointGroup]> {
        APIClient().execute(
            request: SearchRequest(method: .stopPoints, query: query),
            responseMapper: VMResponseMapper(ArrayMapper(StopPointGroupMapper()))
        )
    }
    
    func routes(for line: String) -> Observable<[Route]> {
        APIClient().execute(
            request: NameRequest(name: line, method: .directionsByLine),
            responseMapper: VMResponseMapper(RoutesMapper())
        )
    }
    
    func stopPoints(street: String) -> Observable<[StopPointDirections]> {
        APIClient().execute(
            request: NameRequest(name: street, method: .stopPointsByStreet),
            responseMapper: VMResponseMapper(DirectionsMapper(useTagAsID: false))
        )
    }
    
    func stopPoints(name stopPoint: String) -> Observable<[StopPointDirections]> {
        APIClient().execute(
            request: NameRequest(name: stopPoint, method: .stopPointsByName),
            responseMapper: VMResponseMapper(DirectionsMapper(useTagAsID: true))
        )
    }
}
