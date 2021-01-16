import Foundation
import RxSwift
import RxCocoa

public final class SearchPresenter {
    public enum State {
        case loading
        case empty
        case hasNoResults
        case hasResults
    }
    
    private let disposeBag = DisposeBag()
    private let activityIndicator = SharedActivityIndicator()
    private let results = BehaviorRelay(value: [SearchResult]())
    
    private var searchQuery: Observable<String> {
        view.searchQuery.map({ $0.trimmingCharacters(in: .whitespaces) })
    }

    public unowned let view: SearchView

    public init(view: SearchView) {
        self.view = view
        
        results.bind(to: view.results).disposed(by: disposeBag)
        
        let state = Observable.combineLatest(activityIndicator.current.asObservable(), searchQuery, results) { (isBusy, searchQuery, results) -> State in
            if isBusy {
                return .loading
            }
            if searchQuery.isEmpty {
                return .empty
            }
            if results.isEmpty {
                return .hasNoResults
            }
            return .hasResults
        }
        
        state.distinctUntilChanged()
            .bind(to: view.state)
            .disposed(by: disposeBag)
    }
    
    public func initialize() {
        searchQuery.distinctUntilChanged()
            .flatMapLatest(with: self, { (context, searchQuery) -> Observable<[SearchResult]> in
                if searchQuery.isEmpty {
                    return Observable.just([])
                }
                return Search(query: searchQuery).execute()
                    .trackActivity(context.activityIndicator)
            })
            .bind(to: results)
            .disposed(by: disposeBag)
    }
}
