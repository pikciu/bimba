import Foundation
import RxSwift
import RxCocoa

public final class SearchPresenter {
    private let disposeBag = DisposeBag()
    private let activityIndicator = SharedActivityIndicator()
    private let results = BehaviorRelay(value: [SearchResult]())

    public unowned let view: SearchView

    public init(view: SearchView) {
        self.view = view
        
        results.bind(to: view.results).disposed(by: disposeBag)
    }
    
    public func initialize() {
        
        view.searchQuery.map({ $0.trimmingCharacters(in: .whitespaces) })
            .debounce(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .distinctUntilChanged()
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
