import Foundation
import RxSwift

struct GetStopPoints: UseCase {
    @Inject
    private var remoteRepository: StopPointRemoteRepository
    
    func execute() -> Observable<[StopPointDetails]> {
        remoteRepository.stopPoints()
    }
}
