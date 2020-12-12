import Foundation
import RxSwift
import RxCocoa

public protocol SearchResultDetailsView: class {
    var searchResult: SearchResult { get }
    var routes: AnyObserver<[Route]> { get }
    var selectedRouteIndex: ControlProperty<Int> { get }
    var isRoutesSelectorDisabled: AnyObserver<Bool> { get }
    var items: AnyObserver<[SearchResultDetailsPresenter.Item]> { get }
}
