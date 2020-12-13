import Foundation
import RxSwift

struct FavoriteStopPoints: UseCase {
    @Inject
    private var repository: StopPointLocalRepository
    
    func execute() -> Observable<[StopPointDetails]> {
        Observable.combineLatest(repository.stopPoints(), repository.favoriteStopPointIDs())
            .map(filter(data:))
    }
    
    private func filter(data: ([StopPointDetails], [String])) -> [StopPointDetails] {
        let (stopPoints, favorites) = data
        return stopPoints.filter({ favorites.contains($0.id) })
    }
}
