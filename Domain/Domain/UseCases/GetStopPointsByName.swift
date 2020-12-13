import Foundation
import RxSwift

struct GetStopPointsByName: UseCase {
    @Inject
    private var repository: VMRepository
    
    let name: String
    
    func execute() -> Single<[StopPointDirections]> {
        repository.stopPoints(name: name)
    }
}
