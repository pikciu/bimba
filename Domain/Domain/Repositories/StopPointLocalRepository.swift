import Foundation
import RxSwift

public protocol StopPointLocalRepository {
    
    func saveStopPoints(stopPoints: [StopPointDetails]) -> Completable
    
    func stopPoints() -> Observable<[StopPointDetails]>
    
    func favoriteStopPointIDs() -> Observable<[String]>
    
    func addFavorite(stopPointID: String) -> Completable
    
    func removeFavorite(stopPointID: String) -> Completable
}
