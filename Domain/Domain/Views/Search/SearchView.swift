import Foundation
import RxSwift

public protocol SearchView: class {
    var state: AnyObserver<SearchPresenter.State> { get }
    var results: AnyObserver<[SearchResult]> { get }
    var searchQuery: Observable<String> { get }
}
