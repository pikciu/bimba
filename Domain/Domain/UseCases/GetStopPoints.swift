import Foundation
import RxSwift

struct GetStopPoints: UseCase {
    @Inject
    private var remoteRepository: StopPointRemoteRepository
    
    func execute() -> Observable<[StopPointDetails]> {
        remoteRepository.stopPoints()
            .map(group(stopPoints:))
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
            type: types
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
