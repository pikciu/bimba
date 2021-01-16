import Foundation
import RxSwift

struct GetMessage: UseCase {
    @Inject
    private var repository: VMRepository
    
    let stopPointID: String

    func execute() -> Single<String> {
        repository.message(stopPointID: stopPointID)
    }
}
