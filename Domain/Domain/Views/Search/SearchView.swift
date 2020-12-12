import Foundation
import RxSwift

public protocol SearchView: class {
    var results: AnyObserver<[SearchResult]> { get }
    var searchQuery: Observable<String> { get }
}
