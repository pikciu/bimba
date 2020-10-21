import Foundation
import RxSwift

struct GetDepartureTime: UseCase {
    @Inject
    private var repository: VMRepository
    
    let stopPointID: String
    
    func execute() -> Observable<[DepartureTime]> {
        repository.times(stopPointID: stopPointID)
    }
}
