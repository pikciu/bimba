import Foundation
import RxSwift
import RxCocoa

public protocol SearchView: class {
    var state: AnyObserver<SearchPresenter.State> { get }
    var results: AnyObserver<[SearchResult]> { get }
    var searchQuery: Observable<String> { get }
    var scope: ControlProperty<Int> { get }
    var scopes: AnyObserver<[SearchPresenter.Scope]> { get }
}
