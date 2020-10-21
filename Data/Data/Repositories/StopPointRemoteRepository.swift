import Foundation
import Domain
import RxSwift

struct StopPointRemoteRepository: Domain.StopPointRemoteRepository {
    func stopPoints() -> Observable<[StopPointDetails]> {
        APIClient().execute(
            request: GetStopPointsRequest(),
            responseMapper: StopPointsDetailsMapper()
        )
    }
}
