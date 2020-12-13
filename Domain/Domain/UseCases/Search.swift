import Foundation
import RxSwift

struct Search: UseCase {
    @Inject
    private var repository: VMRepository
    
    let query: String
    
    func execute() -> Observable<[SearchResult]> {
        let lines = repository.searchLines(query: query)
            .map({ $0.map({ SearchResult.line($0) }) })
            .asObservable()
            .startWith([])
        let stopPoints = repository.searchStopPoints(query: query)
            .map({ $0.map({ SearchResult.stopPoint($0) }) })
            .asObservable()
            .startWith([])
        let streets = repository.searchStreets(query: query)
            .map({ $0.map({ SearchResult.street($0) }) })
            .asObservable()
            .startWith([])
        
        return Observable.combineLatest(lines, stopPoints, streets) { $0 + $1 + $2  }
    }
}
