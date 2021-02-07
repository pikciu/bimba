import Intents
import Domain
import Data
import RxSwift

final class IntentHandler: INExtension, ConfigurationIntentHandling {
    private let disposeBag = DisposeBag()
    
    override init() {
        super.init()
        Container.register(modules: DataModule.self)
    }
    
    func provideFavoriteOptionsCollection(for intent: ConfigurationIntent, with completion: @escaping (INObjectCollection<FavoriteStopPoint>?, Error?) -> Void) {
        FavoriteStopPoints()
            .execute()
            .map({ self.map(stopPoints: $0) })
            .subscribe(onNext: { (favorites) in
                completion(INObjectCollection(items: favorites), nil)
            }, onError: { (error) in
                completion(nil, error)
            })
            .disposed(by: disposeBag)
    }
    
    private func map(stopPoints: [StopPointDetails]) -> [FavoriteStopPoint] {
        stopPoints.map(map(stopPoint:))
    }
    
    private func map(stopPoint: StopPointDetails) -> FavoriteStopPoint {
        FavoriteStopPoint(
            identifier: stopPoint.id,
            display: stopPoint.name
        )
    }
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
    deinit {
        debugPrint(self)
    }
    
}
