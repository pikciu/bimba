import Foundation
import RxSwift

struct GetStopPointsByName: UseCase {
    @Inject
    private var repository: VMRepository
    
    let name: String
    
    func execute() -> Observable<[StopPointDirections]> {
        repository.stopPoints(name: name)
    }
}
