import Foundation
import RxSwift

public struct GetDepartureTime: UseCase {
    @Inject
    private var repository: VMRepository
    
    let stopPointID: String
    
    public init(stopPointID: String) {
        self.stopPointID = stopPointID
    }
    
    public func execute() -> Single<[DepartureTime]> {
        repository.times(stopPointID: stopPointID)
    }
}
