import Foundation
import RxSwift

struct GetDepartureTime: UseCase {
    @Inject
    private var repository: VMRepository
    
    let stopPointID: String
    
    func execute() -> Single<[DepartureTime]> {
        repository.times(stopPointID: stopPointID)
    }
}
