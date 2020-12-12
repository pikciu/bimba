import Foundation
import RxSwift

public protocol TimesView: class {
    var stopPoint: StopPointType { get }
    var times: AnyObserver<[DepartureTime]> { get }
}
