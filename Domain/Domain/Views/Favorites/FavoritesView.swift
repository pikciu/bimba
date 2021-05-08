import Foundation
import RxSwift

public protocol FavoritesView: AnyObject {
    var stopPoints: AnyObserver<[StopPointDetails]> { get }
    var isEmpty: AnyObserver<Bool> { get }
}
