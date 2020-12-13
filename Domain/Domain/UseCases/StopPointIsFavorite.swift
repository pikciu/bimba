import Foundation
import RxSwift

struct StopPointIsFavorite: UseCase {
    @Inject
    private var repository: StopPointLocalRepository
    
    let id: String
    
    func execute() -> Observable<Bool> {
        repository.favoriteStopPointIDs()
            .map({ $0.contains(id) })
    }
}
