import Foundation
import RxSwift

struct GetRoutes: UseCase {
    @Inject
    private var repository: VMRepository
    
    let line: String
    
    func execute() -> Observable<[Route]> {
        repository.routes(for: line)
    }
}
