import Foundation
import RxSwift
import RxCocoa

public final class SearchResultDetailsPresenter {
    public enum Item {
        case stopPoint(StopPointDirections)
        case lineStopPoint(StopPoint)
        
        public var stopPoint: StopPoint {
            switch self {
            case .lineStopPoint(let stopPoint):
                return stopPoint
            case .stopPoint(let stopPoint):
                return stopPoint.stopPoint
            }
        }
    }
    
    private let disposeBag = DisposeBag()
    private let activityIndicator = SharedActivityIndicator()
    private let routes = BehaviorRelay(value: [Route]())
    private let stopPoints = BehaviorRelay(value: [StopPointDirections]())
    private let selectedIndex = BehaviorRelay(value: 0)

    public unowned let view: SearchResultDetailsView

    public init(view: SearchResultDetailsView) {
        self.view = view
        
        activityIndicator.current.drive(view.isBusy).disposed(by: disposeBag)
        
        view.selectedRouteIndex.bindTwoWay(selectedIndex)
            .disposed(by: disposeBag)
        
        routes.bind(to: view.routes)
            .disposed(by: disposeBag)
        
        routes.filterEmpty()
            .mapTo(0)
            .bind(to: selectedIndex)
            .disposed(by: disposeBag)
        
        let routeItems = Observable.combineLatest(selectedIndex, routes)
            .map(selectRoute(data:))
            .filterNil()
            .map(map(route:))
            
        let stopPointItems = stopPoints.map(map(stopPoints:))
            
        Observable.merge(routeItems, stopPointItems)
            .bind(to: view.items)
            .disposed(by: disposeBag)
        
        routes.map({ $0.isEmpty })
            .bind(to: view.isRoutesSelectorDisabled)
            .disposed(by: disposeBag)
    }
    
    public func loadDetails() {
        switch view.searchResult {
        case .line(let line):
            loadRoutes(line: line)
        case .stopPoint(let stopPoint):
            loadStopPoints(observable: GetStopPointsByName(name: stopPoint.name).execute())
        case .street(let street):
            loadStopPoints(observable: GetStopPointsByStreet(street: street.name).execute())
        }
    }
    
    private func loadRoutes(line: String) {
        GetRoutes(line: line)
            .execute()
            .trackActivity(activityIndicator)
            .bind(to: routes)
            .disposed(by: disposeBag)
    }
    
    private func loadStopPoints(observable: Single<[StopPointDirections]>) {
        observable.trackActivity(activityIndicator)
            .map({ $0.map(GroupByDirectionName().map(from:)) })
            .bind(to: stopPoints)
            .disposed(by: disposeBag)
    }
    
    private func map(route: Route) -> [Item] {
        route.stopPoints.map({ .lineStopPoint($0) })
    }
    
    private func map(stopPoints: [StopPointDirections]) -> [Item] {
        stopPoints.map({ .stopPoint($0) })
    }
    
    private func selectRoute(data: (Int, [Route])) -> Route? {
        let (index, routes) = data
        if index < 0 {
            return nil
        }
        guard routes.count > index else {
            return nil
        }
        return routes[index]
    }
}
