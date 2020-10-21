import Foundation
import Domain
import RxSwift

struct VMRepository: Domain.VMRepository {
    func times(stopPointID: String) -> Observable<[DepartureTime]> {
        APIClient().execute(
            request: GetDepartureTimesRequest(stopPointID: stopPointID),
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
    
    func searchStopPoints(query: String) -> Observable<[StopPoint]> {
        APIClient().execute(
            request: SearchRequest(method: .stopPoints, query: query),
            responseMapper: VMResponseMapper(ArrayMapper(StopPointMapper()))
        )
    }
}
