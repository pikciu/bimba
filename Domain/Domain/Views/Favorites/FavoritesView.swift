import Foundation
import RxSwift

public protocol FavoritesView: AnyObject {
    var selectedViewIndex: Observable<Int> { get }
    var stopPoints: AnyObserver<[StopPointDetails]> { get }
    var isEmpty: AnyObserver<Bool> { get }
    var noPermissions: AnyObserver<Bool> { get }
}
