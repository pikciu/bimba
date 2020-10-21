import Foundation
import RxSwift

public protocol VMRepository {
    
    func times(stopPointID: String) -> Observable<[DepartureTime]>
    
    func searchLines(query: String) -> Observable<[String]>
    
    func searchStreets(query: String) -> Observable<[Street]>
    
    func searchStopPoints(query: String) -> Observable<[StopPointGroup]>
    
    func routes(for line: String) -> Observable<[Route]>
}
