import Foundation
import RxSwift

public protocol StopPointRemoteRepository {
    
    func stopPoints() -> Single<[StopPointDetails]>
}
