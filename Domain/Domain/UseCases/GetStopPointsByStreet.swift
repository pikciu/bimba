import Foundation
import RxSwift

struct GetStopPointsByStreet: UseCase {
    @Inject
    private var repository: VMRepository
    
    let street: String
    
    func execute() -> Single<[StopPointDirections]> {
        repository.stopPoints(street: street)
    }
}
