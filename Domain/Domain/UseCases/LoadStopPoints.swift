import Foundation
import RxSwift

public struct LoadStopPoints: UseCase {
    @Inject
    private var remoteRepository: StopPointRemoteRepository
    @Inject
    private var localRepository: StopPointLocalRepository
    
    public init() {
        
    }
    
    public func execute() -> Completable {
        remoteRepository.stopPoints()
            .map(group(stopPoints:))
            .flatMapCompletable({ localRepository.saveStopPoints(stopPoints: $0) })
    }
    
    private func group(stopPoints: [StopPointDetails]) -> [StopPointDetails] {
        Dictionary(grouping: stopPoints) { StopPointGroup(stopPoint: $0) }
            .map(merge(group:))
    }
    
    private func merge(group: (StopPointGroup, [StopPointDetails])) -> StopPointDetails {
        let (group, stopPoints) = group
        let types = stopPoints.flatMap({ $0.type })
        return StopPointDetails(
            id: group.id,
            coordinates: group.coordinates,
            name: group.name,
            type: types.sorted()
        )
    }
    
    private struct StopPointGroup: Hashable {
        
        let id: String
        let name: String
        let coordinates: StopPointDetails.Coordinates
        
        init(stopPoint: StopPointDetails) {
            self.id = stopPoint.id
            self.name = stopPoint.name
            self.coordinates = stopPoint.coordinates
        }
    }
}
