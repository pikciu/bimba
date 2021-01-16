import Foundation
import RxSwift

public protocol SearchView: class {
    var isBusy: AnyObserver<Bool> { get }
    var results: AnyObserver<[SearchResult]> { get }
    var searchQuery: Observable<String> { get }
}
