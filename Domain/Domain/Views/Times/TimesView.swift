import Foundation
import RxSwift

public protocol TimesView: class {
    var isBusy: AnyObserver<Bool> { get }
    var stopPoint: StopPointType { get }
    var times: AnyObserver<[DepartureTime]> { get }
    var isFavorite: AnyObserver<Bool> { get }
    var toggleFavorite: Observable<Void> { get }
    var message: AnyObserver<String?> { get }
}
