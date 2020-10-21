import Foundation
import RxSwift

public protocol StopPointRemoteRepository {
    
    func stopPoints() -> Observable<[StopPointDetails]>
}
