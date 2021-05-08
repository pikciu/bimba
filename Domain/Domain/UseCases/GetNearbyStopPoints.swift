import Foundation
import RxSwift
import CoreLocation

public struct GetNearbyStopPoints: UseCase {
    @Inject
    private var repository: StopPointLocalRepository
    
    let location: CLLocation
    
    public init(location: CLLocation) {
        self.location = location
    }
    
    public func execute() -> Observable<[StopPointDetails]> {
        repository.stopPoints()
            .map(sorted(stopPoints:))
            .map(stopPointGroup(stopPoints:))
    }
    
    private func sorted(stopPoints: [StopPointDetails]) -> [StopPointDetails] {
        stopPoints.sorted(by: { (left, right) in
            let leftDistance = left.location.distance(from: location)
            let rightDistance = right.location.distance(from: location)
            return abs(leftDistance) < abs(rightDistance)
        })
    }
    
    private func stopPointGroup(stopPoints: [StopPointDetails]) -> [StopPointDetails] {
        guard let nearest = stopPoints.first else {
            return []
        }
        return stopPoints.prefix(while: { $0.name == nearest.name })
            .sorted(key: \.id)
    }
}

private extension StopPointDetails {
    
    var location: CLLocation {
        CLLocation(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
    }
}
