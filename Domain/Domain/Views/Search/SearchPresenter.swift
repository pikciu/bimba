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
    
    public enum Scope: Int, CaseIterable {
        case all = 0
        case line
        case stopPoint
        case street
    }
    
    private let disposeBag = DisposeBag()
    private let activityIndicator = SharedActivityIndicator()
    private let results = BehaviorRelay(value: [SearchResult]())
    private let scopeIndex = BehaviorRelay(value: 0)
    
    private var searchQuery: Observable<String> {
        view.searchQuery.map({ $0.trimmingCharacters(in: .whitespaces) })
    }

    public unowned let view: SearchView

    public init(view: SearchView) {
        self.view = view
        
        let scope = scopeIndex.map({ Scope(rawValue: $0) }).filterNil()
        
        Observable.combineLatest(scope, results)
            .map(filter(scope:results:))
            .bind(to: view.results)
            .disposed(by: disposeBag)
        
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
        
        Observable.just(Scope.allCases)
            .bind(to: view.scopes)
            .disposed(by: disposeBag)
        
        view.scope.bindTwoWay(scopeIndex)
            .disposed(by: disposeBag)
    }
    
    public func initialize() {
        searchQuery.distinctUntilChanged()
            .withUnretained(self)
            .flatMapLatest({ (context, searchQuery) -> Observable<[SearchResult]> in
                if searchQuery.isEmpty {
                    return Observable.just([])
                }
                return Search(query: searchQuery).execute()
                    .trackActivity(context.activityIndicator)
            })
            .bind(to: results)
            .disposed(by: disposeBag)
    }
    
    private func filter(scope: Scope, results: [SearchResult]) -> [SearchResult] {
        results.filter({ $0.match(scope: scope) })
    }
}

extension SearchResult {
    
    func match(scope: SearchPresenter.Scope) -> Bool {
        if case .all = scope {
            return true
        }
        switch self {
        case .line:
            return scope == .line
        case .stopPoint:
            return scope == .stopPoint
        case .street:
            return scope == .street
        }
    }
}
