import Foundation
import RxSwift

struct GetStopPoints: UseCase {
    @Inject
    private var repository: StopPointLocalRepository
    
    func execute() -> Observable<[StopPointDetails]> {
        repository.stopPoints()
            .distinctUntilChanged()
    }
}
