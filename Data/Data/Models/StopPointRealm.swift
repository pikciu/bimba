import Foundation
import RealmSwift
import Domain

final class StopPointRealm: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var busHeadsings: String? = nil
    @objc dynamic var tramHeadsings: String? = nil
    
    override class func primaryKey() -> String? {
        "id"
    }
}

struct StopPointRealmMapper: Mapper {
    
    func map(from object: StopPointRealm) -> StopPointDetails {
        StopPointDetails(
            id: object.id,
            coordinates: StopPointDetails.Coordinates(
                latitude: object.latitude,
                longitude: object.longitude
            ),
            name: object.name,
            type: routes(stopPoint: object)
        )
    }
    
    private func routes(stopPoint: StopPointRealm) -> [StopPointDetails.Route] {
        var routes = [StopPointDetails.Route]()
        if let tram = stopPoint.tramHeadsings {
            routes.append(.tram(tram))
        }
        if let bus = stopPoint.busHeadsings {
            routes.append(.bus(bus))
        }
        return routes.sorted()
    }
}

struct StopPointDetailsToRealmMapper: Mapper {
    
    func map(from object: StopPointDetails) -> StopPointRealm {
        let stopPoint = StopPointRealm()
        stopPoint.id = object.id
        stopPoint.name = object.name
        stopPoint.latitude = object.coordinates.latitude
        stopPoint.longitude = object.coordinates.longitude
        stopPoint.busHeadsings = busHeadsings(stopPoint: object)
        stopPoint.tramHeadsings = tramHeadsings(stopPoint: object)
        return stopPoint
    }
    
    private func busHeadsings(stopPoint: StopPointDetails) -> String? {
        let bus = stopPoint.type.first(where: isBus())
        return bus?.headsings
    }
    
    private func tramHeadsings(stopPoint: StopPointDetails) -> String? {
        let tram = stopPoint.type.first(where: isTram())
        return tram?.headsings
    }
    
    private func isBus() -> (StopPointDetails.Route) -> Bool {
        return { (type) in
            if case .bus = type {
                return true
            }
            return false
        }
    }
    
    private func isTram() -> (StopPointDetails.Route) -> Bool {
        return { (type) in
            if case .tram = type {
                return true
            }
            return false
        }
    }
}
