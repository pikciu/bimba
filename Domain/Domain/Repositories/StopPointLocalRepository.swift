import Foundation
import RxSwift

public protocol StopPointLocalRepository {
    
    func stopPoints() -> Observable<[StopPointDetails]>
    
    func favoriteStopPointIDs() -> Observable<[String]>
    
    func addFavorite(stopPointID: String)
    
    func removeFavorite(stopPointID: String)
}
