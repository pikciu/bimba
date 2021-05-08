import Foundation
import RxSwift

public protocol TimesView: AnyObject {
    var isBusy: AnyObserver<Bool> { get }
    var stopPoint: StopPointType { get }
    var times: AnyObserver<[DepartureTime]> { get }
    var isFavorite: AnyObserver<Bool> { get }
    var toggleFavorite: Observable<Void> { get }
    var message: AnyObserver<String?> { get }
}
