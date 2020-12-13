import Foundation
import RxSwift

public protocol VMRepository {
    
    func times(stopPointID: String) -> Single<[DepartureTime]>
    
    func searchLines(query: String) -> Single<[String]>
    
    func searchStreets(query: String) -> Single<[Street]>
    
    func searchStopPoints(query: String) -> Single<[StopPointGroup]>
    
    func routes(for line: String) -> Single<[Route]>
    
    func stopPoints(street: String) -> Single<[StopPointDirections]>
    
    func stopPoints(name stopPoint: String) -> Single<[StopPointDirections]>
}
