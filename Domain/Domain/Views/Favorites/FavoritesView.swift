import Foundation
import RxSwift

public protocol FavoritesView: class {
    var stopPoints: AnyObserver<[StopPointDetails]> { get }
}
