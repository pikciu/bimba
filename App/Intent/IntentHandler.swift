import Intents
import Domain
import Data
import RxSwift
import DependencyContainer

final class IntentHandler: INExtension, ConfigurationIntentHandling {
    
    override init() {
        super.init()
        Container.register(modules: [DataModule.self])
    }
    
    func provideFavoriteOptionsCollection(for intent: ConfigurationIntent, with completion: @escaping (INObjectCollection<FavoriteStopPoint>?, Error?) -> Void) {
        
        _ = FavoriteStopPoints()
            .execute()
            .subscribe(on: MainScheduler.asyncInstance)
            .take(1)
            .map({ (stopPoints) in
                stopPoints.map({ (stopPoint) in
                    FavoriteStopPoint(stopPoint: stopPoint)
                })
            })
            .subscribe(onNext: { (favorites) in
                completion(INObjectCollection(items: favorites), nil)
            }, onError: { (error) in
                completion(nil, error)
            })
    }
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}

extension FavoriteStopPoint {
    convenience init(stopPoint: StopPointDetails) {
        self.init(identifier: stopPoint.id, display: stopPoint.name)
        subtitleString = stopPoint.headsings
    }
}
