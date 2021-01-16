import Foundation
import RxSwift
import RxCocoa
import RxSwiftUtilities

public extension Observable {
    
    static func just(factory: @escaping () throws -> Element) -> Observable<Element> {
        Observable.create({ (observer) -> Disposable in
            do {
                try observer.onNext(factory())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        })
    }
}


extension ControlProperty {
    
    func bindTwoWay(_ relay: BehaviorRelay<Element>) -> Disposable {
        self <-> relay
    }
}
